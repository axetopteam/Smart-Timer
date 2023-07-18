import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/purchasing/paywalls/paywalls_ids.dart';
import 'package:smart_timer/purchasing/purchase_manager.dart';

export 'package:smart_timer/purchasing/purchase_manager.dart' show PurchaseResult, PurchaseResultType;

part 'paywall_state.g.dart';

class PaywallState = _PaywallState with _$PaywallState;

abstract class _PaywallState with Store {
  _PaywallState() {
    initialize();
  }
  final purchaseManager = PurchaseManager();

  @observable
  AdaptyPaywall? paywall;

  @observable
  List<AdaptyPaywallProduct>? products;

  @observable
  AdaptyPaywallProduct? selectedProduct;

  @observable
  Object? error;

  @observable
  bool purchaseInProgress = false;

  @observable
  PurchaseResult? purchaseResult;

  @observable
  Future<void> initialize() async {
    if (paywall == null) {
      await _fetchPaywall();
    }
    await _fetchPaywallProducts();
  }

  @action
  Future<void> _fetchPaywall() async {
    try {
      error = null;

      paywall = await purchaseManager.getOrLoadPaywall(mainPaywallId);
    } catch (e) {
      error = e;
    }
  }

  bool _paywallShowLogged = false;

  @action
  Future<void> _fetchPaywallProducts({bool ensureEligibility = false}) async {
    try {
      error = null;

      products = await purchaseManager.getPaywallProducts(paywall!, ensureEligibility: ensureEligibility);

      selectedProduct ??= products?.firstOrNull;

      if (!_paywallShowLogged) {
        purchaseManager.logShowPaywall(paywall!);
        _paywallShowLogged = true;
      }

      var shouldReloadProducts = false;

      final result =
          products?.firstWhereOrNull((element) => element.introductoryOfferEligibility == AdaptyEligibility.unknown);
      shouldReloadProducts = result != null;

      if (shouldReloadProducts) {
        await _fetchPaywallProducts(ensureEligibility: true);
      }
    } catch (e) {
      error = products != null ? null : e;
    }
  }

  @action
  void selectProduct(AdaptyPaywallProduct product) {
    selectedProduct = product;
  }

  @action
  Future<void> restorePurchase() async {
    purchaseResult = null;
    if (purchaseInProgress) return;
    purchaseInProgress = true;
    purchaseResult = await purchaseManager.restorePurchases();
    purchaseInProgress = false;
  }

  @action
  Future<void> makePurchase(AdaptyPaywallProduct product) async {
    purchaseResult = null;
    if (purchaseInProgress) return;
    purchaseInProgress = true;
    purchaseResult = await purchaseManager.makePurchase(product);
    purchaseInProgress = false;
  }
}
