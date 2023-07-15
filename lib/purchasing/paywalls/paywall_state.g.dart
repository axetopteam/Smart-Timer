// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paywall_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PaywallState on _PaywallState, Store {
  late final _$paywallAtom =
      Atom(name: '_PaywallState.paywall', context: context);

  @override
  AdaptyPaywall? get paywall {
    _$paywallAtom.reportRead();
    return super.paywall;
  }

  @override
  set paywall(AdaptyPaywall? value) {
    _$paywallAtom.reportWrite(value, super.paywall, () {
      super.paywall = value;
    });
  }

  late final _$productsAtom =
      Atom(name: '_PaywallState.products', context: context);

  @override
  List<AdaptyPaywallProduct>? get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(List<AdaptyPaywallProduct>? value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$selectedProductAtom =
      Atom(name: '_PaywallState.selectedProduct', context: context);

  @override
  AdaptyPaywallProduct? get selectedProduct {
    _$selectedProductAtom.reportRead();
    return super.selectedProduct;
  }

  @override
  set selectedProduct(AdaptyPaywallProduct? value) {
    _$selectedProductAtom.reportWrite(value, super.selectedProduct, () {
      super.selectedProduct = value;
    });
  }

  late final _$errorAtom = Atom(name: '_PaywallState.error', context: context);

  @override
  Object? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(Object? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$purchaseInProgressAtom =
      Atom(name: '_PaywallState.purchaseInProgress', context: context);

  @override
  bool get purchaseInProgress {
    _$purchaseInProgressAtom.reportRead();
    return super.purchaseInProgress;
  }

  @override
  set purchaseInProgress(bool value) {
    _$purchaseInProgressAtom.reportWrite(value, super.purchaseInProgress, () {
      super.purchaseInProgress = value;
    });
  }

  late final _$_fetchPaywallAsyncAction =
      AsyncAction('_PaywallState._fetchPaywall', context: context);

  @override
  Future<void> _fetchPaywall() {
    return _$_fetchPaywallAsyncAction.run(() => super._fetchPaywall());
  }

  late final _$_fetchPaywallProductsAsyncAction =
      AsyncAction('_PaywallState._fetchPaywallProducts', context: context);

  @override
  Future<void> _fetchPaywallProducts({bool ensureEligibility = false}) {
    return _$_fetchPaywallProductsAsyncAction.run(() =>
        super._fetchPaywallProducts(ensureEligibility: ensureEligibility));
  }

  late final _$restorePurchaseAsyncAction =
      AsyncAction('_PaywallState.restorePurchase', context: context);

  @override
  Future<void> restorePurchase() {
    return _$restorePurchaseAsyncAction.run(() => super.restorePurchase());
  }

  late final _$makePurchaseAsyncAction =
      AsyncAction('_PaywallState.makePurchase', context: context);

  @override
  Future<void> makePurchase(AdaptyPaywallProduct product) {
    return _$makePurchaseAsyncAction.run(() => super.makePurchase(product));
  }

  late final _$_PaywallStateActionController =
      ActionController(name: '_PaywallState', context: context);

  @override
  void selectProduct(AdaptyPaywallProduct product) {
    final _$actionInfo = _$_PaywallStateActionController.startAction(
        name: '_PaywallState.selectProduct');
    try {
      return super.selectProduct(product);
    } finally {
      _$_PaywallStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
paywall: ${paywall},
products: ${products},
selectedProduct: ${selectedProduct},
error: ${error},
purchaseInProgress: ${purchaseInProgress}
    ''';
  }
}
