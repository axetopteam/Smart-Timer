import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/purchasing/paywalls/paywalls_ids.dart';
import 'package:smart_timer/purchasing/purchase_manager.dart';

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
      purchaseManager.logShowPaywall(paywall!);
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<void> _fetchPaywallProducts({bool ensureEligibility = false}) async {
    try {
      error = null;
      products = await purchaseManager.getPaywallProducts(paywall!, ensureEligibility: ensureEligibility);

      selectedProduct ??= products?.firstOrNull;

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
    if (purchaseInProgress) return;
    purchaseInProgress = true;
    await purchaseManager.restorePurchases();
    purchaseInProgress = false;
  }

  @action
  Future<void> makePurchase(AdaptyPaywallProduct product) async {
    if (purchaseInProgress) return;
    purchaseInProgress = true;
    await purchaseManager.makePurchase(product);
    purchaseInProgress = false;
  }
}
