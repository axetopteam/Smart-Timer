import 'dart:async';

import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_timer/services/app_properties.dart';

/// PurchaseManager singleton class
class PurchaseManager {
  static final _paywallIds = ['paywall_test'];

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

      // await _setFallbackPaywalls();
      await _initializePaywalls();

      profileStreamSubscription = Adapty().didUpdateProfileStream.listen((profile) {
        _onProfileUpdated?.call(profile);
      });

      debugPrint('#PurchaseManager#  Adapty activate and identify!');
    } catch (e) {
      debugPrint('#PurchaseManager# Adapty activate and/or identify failed. Error: $e');
      return false;
    }

    return true;
  }

  //заранее загружает все пэйволы и их продукты
  Future<void> _initializePaywalls() async {
    for (var paywallId in _paywallIds) {
      await _loadAndStorePaywall(paywallId, preloadProducts: true);
    }
  }

  //загружает пэйвол по id и его продукты
  Future<AdaptyPaywall?> _loadAndStorePaywall(
    String paywallId, {
    required bool preloadProducts,
  }) async {
    try {
      final newPaywall = await Adapty().getPaywall(id: paywallId);
      _paywalls.addAll({paywallId: newPaywall});

      if (preloadProducts) {
        final paywallProducts = await Adapty().getPaywallProducts(paywall: newPaywall);
        _products.addAll({newPaywall: paywallProducts});
      }

      return newPaywall;
    } catch (e) {
      return null;
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
