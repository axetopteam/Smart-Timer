import 'dart:async';
import 'dart:io';

import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:smart_timer/analytics/analytics_manager.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/services/app_properties.dart';

import 'adapty_extensions.dart';
import 'paywalls/paywalls_ids.dart';

enum PurchaseResultType {
  userCancelled,
  fail,
  restoreFail,
  success,
}

class PurchaseResult {
  PurchaseResult(this.type, {this.profile, this.errorCode, this.message});
  final PurchaseResultType type;
  final AdaptyProfile? profile;
  final int? errorCode;
  final String? message;
}

/// PurchaseManager singleton class
class PurchaseManager {
  static final _paywallIds = [mainPaywallId];

  static final PurchaseManager _internalSingleton = PurchaseManager._internal();
  factory PurchaseManager() => _internalSingleton;
  PurchaseManager._internal();

  bool _initialized = false;

  StreamSubscription<AdaptyProfile>? profileStreamSubscription;

  void Function(AdaptyProfile profile)? _onProfileUpdated;

  final Map<String, AdaptyPaywall> _paywalls = {};
  final Map<AdaptyPaywall, List<AdaptyPaywallProduct>> _products = {};

  Future<bool> initialize({void Function(AdaptyProfile profile)? onProfileUpdated}) async {
    _onProfileUpdated = onProfileUpdated;
    _initialized = await _initializeAdapty();

    return _initialized;
  }

  Future<bool> _initializeAdapty() async {
    if (_initialized) return _initialized;
    try {
      Adapty().activate();
      await Adapty().identify(AppProperties().userId!);
      if (kDebugMode) {
        await Adapty().setLogLevel(AdaptyLogLevel.verbose);
      }

      profileStreamSubscription = Adapty().didUpdateProfileStream.listen((profile) {
        _onProfileUpdated?.call(profile);
      });

      await _setFallbackPaywalls();
      await _initializePaywalls();

      debugPrint('#PurchaseManager#  Adapty activate and identify!');
      _initialized = true;
      return true;
    } catch (e) {
      debugPrint('#PurchaseManager# Adapty activate and/or identify failed. Error: $e');
      return false;
    }
  }

  Future<void> _setFallbackPaywalls() async {
    try {
      final filePath = Platform.isIOS
          ? 'assets/paywall_fallbacks/ios_fallback.json'
          : 'assets/paywall_fallbacks/android_fallback.json';
      final jsonString = await rootBundle.loadString(filePath);
      await Adapty().setFallbackPaywalls(jsonString);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //заранее загружает все пэйволы и их продукты
  Future<void> _initializePaywalls() async {
    for (var paywallId in _paywallIds) {
      try {
        await _loadAndStorePaywall(paywallId, preloadProducts: true);
      } catch (_) {}
    }
  }

  //загружает пэйвол по id и его продукты
  Future<AdaptyPaywall> _loadAndStorePaywall(
    String paywallId, {
    required bool preloadProducts,
  }) async {
    final newPaywall = await Adapty().getPaywall(id: paywallId);
    _paywalls.addAll({paywallId: newPaywall});

    if (preloadProducts) {
      final paywallProducts = await Adapty().getPaywallProducts(paywall: newPaywall);
      _products.addAll({newPaywall: paywallProducts});
    }

    return newPaywall;
  }

  //пытается взять из кэша пэйвол по id, если не нашел в кэше, загружает из адапти
  Future<AdaptyPaywall> getOrLoadPaywall(String paywallId) async {
    final paywall = _paywalls[paywallId];
    if (paywall != null) {
      return paywall;
    } else {
      final paywall = await _loadAndStorePaywall(paywallId, preloadProducts: false);
      return paywall;
    }
  }

  //пытается взять из кэша продукты для нужного пэйвола
  Future<List<AdaptyPaywallProduct>> getPaywallProducts(
    AdaptyPaywall paywall, {
    bool ensureEligibility = false,
  }) async {
    final List<AdaptyPaywallProduct> paywallProducts;
    if (!ensureEligibility) {
      paywallProducts = _products[paywall] ??
          (await Adapty()
              .getPaywallProducts(paywall: paywall, fetchPolicy: AdaptyIOSProductsFetchPolicy.defaultPolicy));
    } else {
      paywallProducts = await Adapty()
          .getPaywallProducts(paywall: paywall, fetchPolicy: AdaptyIOSProductsFetchPolicy.waitForReceiptValidation);
    }
    _products.addAll({paywall: paywallProducts});
    return paywallProducts;
  }

  Future<PurchaseResult> makePurchase(AdaptyPaywallProduct product) async {
    unawaited(
        FirebaseCrashlytics.instance.log('#PurchaseManager# initiatePurchase productId = ${product.vendorProductId}'));

    try {
      var makePurchaseResult = await Adapty().makePurchase(product: product);
      final premium = makePurchaseResult?.accessLevels[premiumAccessLevelKey]?.isActive ?? false;

      unawaited(FirebaseCrashlytics.instance.log('#PurchaseManager# premium = $premium'));

      if (premium) {
        _logSuccessPurchase(product);
      }

      return premium
          ? PurchaseResult(PurchaseResultType.success, profile: makePurchaseResult)
          : PurchaseResult(PurchaseResultType.fail, message: 'Unknown error');
    } on AdaptyError catch (adaptyError) {
      if (adaptyError.code == AdaptyErrorCode.paymentCancelled) {
        unawaited(FirebaseCrashlytics.instance.log('#PurchaseManager# userCancelled'));
        _logErrorPurchase(productInfo: product, isUserCanceled: true);

        return PurchaseResult(PurchaseResultType.userCancelled);
      } else {
        unawaited(FirebaseCrashlytics.instance.log('#PurchaseManager# error = $adaptyError'));

        final message = adaptyError.message;
        final errorCode = adaptyError.code;
        _logErrorPurchase(productInfo: product, isUserCanceled: false, errorCode: errorCode);

        return PurchaseResult(PurchaseResultType.fail, message: message, errorCode: errorCode);
      }
    } catch (e) {
      _logErrorPurchase(productInfo: product, isUserCanceled: false);
      unawaited(FirebaseCrashlytics.instance.log('#PurchaseManager# error = $e'));
      return PurchaseResult(PurchaseResultType.fail, message: e.toString());
    }
  }

  Future<PurchaseResult> restorePurchases() async {
    try {
      var profile = await Adapty().restorePurchases();

      return profile.hasPremium
          ? PurchaseResult(PurchaseResultType.success, profile: profile)
          : PurchaseResult(
              PurchaseResultType.restoreFail,
              message: LocaleKeys.paywall_restore_error_no_active_subscription.tr(),
            );
    } on AdaptyError catch (adaptyError) {
      final message = adaptyError.message;
      final errorCode = adaptyError.code;
      return PurchaseResult(PurchaseResultType.restoreFail, errorCode: errorCode, message: message);
    } catch (e) {
      return PurchaseResult(
        PurchaseResultType.restoreFail,
        message: e.toString(),
      );
    }
  }

  Future<AdaptyProfile?> getProfile() async {
    try {
      final profile = await Adapty().getProfile();
      return profile;
    } catch (e) {
      debugPrint('#PurchaseManager# Failed to get profile, error = $e');
      return null;
    }
  }

  Future<void> logShowPaywall(AdaptyPaywall paywall) async {
    try {
      await Adapty().logShowPaywall(paywall: paywall);
    } catch (e) {
      Future.delayed(const Duration(seconds: 5), () => logShowPaywall(paywall));
    }
  }

  void _logSuccessPurchase(AdaptyPaywallProduct product) {
    final trialDuration = product.introductoryDiscount?.subscriptionPeriod.inDays;
    if (product.trialIsAvailable && trialDuration != null) {
      AnalyticsManager.eventSubscriptionTrialActivated
        ..setProperty('product_id', product.vendorProductId)
        ..setProperty('price', product.price)
        ..setProperty('currency', product.currencyCode)
        ..setProperty('trial_option', '${trialDuration}_days')
        ..commit();
    } else {
      AnalyticsManager.eventSubscriptionPurchaseDone
        ..setProperty('product_id', product.vendorProductId)
        ..setProperty('price', product.price)
        ..setProperty('currency', product.currencyCode)
        ..commit();
    }
  }

  void _logErrorPurchase({
    required AdaptyPaywallProduct productInfo,
    required bool isUserCanceled,
    int? errorCode,
  }) {
    AnalyticsManager.eventSubscriptionPurchaseFailed
      ..setProperty('product_id', productInfo.vendorProductId)
      ..setProperty('price', productInfo.price)
      ..setProperty('currency', productInfo.currencyCode)
      ..setProperty('reason', isUserCanceled ? 'cancel' : 'fail')
      ..setProperty('error_code', errorCode)
      ..commit();
  }
}
