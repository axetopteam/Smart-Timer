import 'dart:async';

import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_timer/services/app_properties.dart';

import 'adapty_extensions.dart';
import 'paywalls/paywalls_ids.dart';

enum PurchaseResult { userCancelled, fail, success }

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

      // await _setFallbackPaywalls();
      await _initializePaywalls();

      debugPrint('#PurchaseManager#  Adapty activate and identify!');
      _initialized = true;
      return true;
    } catch (e) {
      debugPrint('#PurchaseManager# Adapty activate and/or identify failed. Error: $e');
      return false;
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
    // unawaited(
    //     FirebaseCrashlytics.instance.log('#PurchaseManager# initiatePurchase productId = ${productInfo.productId}'));

    try {
      var makePurchaseResult = await Adapty().makePurchase(product: product);
      final premium = makePurchaseResult?.accessLevels[premiumAccessLevelKey]?.isActive ?? false;

      // unawaited(FirebaseCrashlytics.instance.log('#PurchaseManager# premium = $premium'));

      // if (premium) logSuccesPurchase(productInfo);

      return premium ? PurchaseResult.success : PurchaseResult.fail;
    } on AdaptyError catch (adaptyError) {
      if (adaptyError.code == AdaptyErrorCode.paymentCancelled) {
        // unawaited(FirebaseCrashlytics.instance.log('#PurchaseManager# userCancelled'));
        // logErrorPurchase(productInfo: productInfo, isUserCanceled: true);

        return PurchaseResult.userCancelled;
      } else {
        // unawaited(FirebaseCrashlytics.instance.log('#PurchaseManager# error = $adaptyError'));

        // final message = adaptyError.message;
        // final errorCode = adaptyError.code;
        // logErrorPurchase(productInfo: productInfo, isUserCanceled: false, errorCode: errorCode);

        return PurchaseResult.fail;
      }
    } catch (e) {
      // logErrorPurchase(productInfo: productInfo, isUserCanceled: false);
      // unawaited(FirebaseCrashlytics.instance.log('#PurchaseManager# error = $e'));
      return PurchaseResult.fail;
    }
  }

  Future<PurchaseResult> restorePurchases() async {
    try {
      var profile = await Adapty().restorePurchases();

      return profile.hasPremium ? PurchaseResult.success : PurchaseResult.fail;
    } catch (e) {
      return PurchaseResult.fail;
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
}
