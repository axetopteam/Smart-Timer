import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/analytics/analytics_manager.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/purchasing/adapty_extensions.dart';
import 'package:smart_timer/purchasing/paywalls/paywall_state.dart';
import 'package:smart_timer/utils/interable_extension.dart';
import 'package:smart_timer/utils/utils.dart';
import 'package:smart_timer/widgets/adaptive_alert.dart';

import 'product_container.dart';

class PaywallPage extends StatefulWidget {
  const PaywallPage({super.key});

  static Future<bool?> show(BuildContext context) {
    return showCupertinoModalPopup<bool>(
        context: context,
        builder: (context) {
          return const PaywallPage();
        });
  }

  @override
  State<PaywallPage> createState() => _PaywallPageState();
}

class _PaywallPageState extends State<PaywallPage> {
  final state = PaywallState();

  late final ReactionDisposer _errorReactionDisposer;
  late final ReactionDisposer _makePurchaseReactionDisposer;

  @override
  void initState() {
    AnalyticsManager.eventPaywallOpened.commit();
    _errorReactionDisposer = reaction(
      (_) => state.error,
      (error) async {
        if (error != null) {
          await _showLoadErrorAlert();
          AnalyticsManager.eventPaywallClosed.setProperty('premiumActivated', false);
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop(false);
        }
      },
    );

    _makePurchaseReactionDisposer = reaction<PurchaseResult?>(
      (_) => state.purchaseResult,
      (purchaseResult) {
        if (purchaseResult?.type == PurchaseResultType.success) {
          AnalyticsManager.eventPaywallClosed.setProperty('premiumActivated', true);
          Navigator.of(context).pop(true);
        }
        if (purchaseResult?.type == PurchaseResultType.fail) {
          _showPurchaseError(errorCode: purchaseResult?.errorCode, message: purchaseResult?.message);
        }
      },
    );
    super.initState();
  }

  @override
  dispose() {
    _errorReactionDisposer();
    _makePurchaseReactionDisposer();
    super.dispose();
  }

  Future<void> _showLoadErrorAlert() async {
    return await AdaptiveDialog.show(
      context,
      title: LocaleKeys.paywall_loading_error_title.tr(),
      content: LocaleKeys.paywall_loading_error_title.tr(),
    );
  }

  Future<void> _showPurchaseError({int? errorCode, String? message}) async {
    AdaptiveDialog.show(
      context,
      title: LocaleKeys.paywall_purchase_error_title.tr(),
      content: LocaleKeys.paywall_purchase_error_title.tr(
        namedArgs: {
          'errorCode': '${errorCode ?? 'Unknonwn'}',
          'message': message ?? '',
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final safeOffset = mq.viewPadding;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    SizedBox(height: safeOffset.top + 80),
                    Text(
                      LocaleKeys.paywall_title.tr(),
                      style: context.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 40),
                    _featuresList(),
                    const SizedBox(height: 40),
                    Observer(builder: (ctx) {
                      final products = state.products;

                      if (products == null) {
                        return const ProductContainerPlaceholder();
                      } else {
                        return Column(
                            children: products
                                .map(
                                  (product) => ProductContainer(
                                    product: product,
                                    isSelected: product == state.selectedProduct,
                                    onTap: state.selectProduct,
                                  ),
                                )
                                .toList());
                      }
                    }),
                  ],
                ),
              ),
              _bottomBlock(safeOffset)
            ],
          ),
          _closeButton(safeOffset),
          Observer(builder: (context) {
            if (state.purchaseInProgress) {
              return Positioned.fill(
                child: Container(
                  color: context.color.pauseOverlayColor,
                  height: 20,
                  width: 20,
                  child: const CupertinoActivityIndicator(radius: 20),
                ),
              );
            }
            return const SizedBox();
          }),
        ],
      ),
    );
  }

  Positioned _closeButton(EdgeInsets safeOffset) {
    return Positioned(
      top: safeOffset.top + 20,
      child: IconButton(
        onPressed: () {
          AnalyticsManager.eventPaywallClosed.setProperty('premiumActivated', false);
          Navigator.of(context).pop(false);
        },
        icon: Icon(
          CupertinoIcons.clear_circled_solid,
          size: 40,
          color: context.color.mainText,
        ),
      ),
    );
  }

  Widget _bottomBlock(EdgeInsets safeOffset) {
    return Observer(builder: (context) {
      final selectedProduct = state.selectedProduct;

      String? title = selectedProduct == null
          ? null
          : selectedProduct.isUnlim
              ? null
              : LocaleKeys.paywall_bottom_block_no_commitments.tr();

      String? subtitle = selectedProduct == null
          ? null
          : selectedProduct.trialIsAvailable
              ? LocaleKeys.paywall_bottom_block_trial.tr()
              : null;

      return Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, safeOffset.bottom + 20),
        decoration: BoxDecoration(
          color: context.color.background,
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF8E8E93), //TODO: add to theme
              blurRadius: 8,
              offset: Offset(0, -8),
              spreadRadius: -8,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  title,
                  style: TextStyle(color: context.color.secondaryText),
                ),
              ),
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  subtitle,
                  style: context.textTheme.titleMedium,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButtonTheme(
                data: context.buttonThemes.paywallButtonTheme,
                child: ElevatedButton(
                  onPressed: selectedProduct != null ? () => state.makePurchase(selectedProduct) : null,
                  child: Container(
                    width: double.maxFinite,
                    alignment: Alignment.center,
                    child: Text(LocaleKeys.paywall_bottom_block_button_title.tr()),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: ButtonStyle(foregroundColor: MaterialStatePropertyAll(context.color.secondaryText)),
                  onPressed: AppUtils.openTermsOfUse,
                  child: Text(LocaleKeys.paywall_bottom_block_terms.tr()),
                ),
                TextButton(
                  style: ButtonStyle(foregroundColor: MaterialStatePropertyAll(context.color.secondaryText)),
                  onPressed: state.restorePurchase,
                  child: Text(LocaleKeys.paywall_bottom_block_restore.tr()),
                ),
                TextButton(
                  style: ButtonStyle(foregroundColor: MaterialStatePropertyAll(context.color.secondaryText)),
                  onPressed: AppUtils.openPrivacyPolicy,
                  child: Text(LocaleKeys.paywall_bottom_block_privacy.tr()),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Column _featuresList() {
    return Column(
      children: [
        _featureRow(
          icon: Icons.all_inclusive,
          title: LocaleKeys.paywall_features_1_title.tr(),
          subtitle: LocaleKeys.paywall_features_1_subtitle.tr(),
        ),
        _featureRow(
          icon: CupertinoIcons.nosign,
          title: LocaleKeys.paywall_features_2_title.tr(),
          subtitle: LocaleKeys.paywall_features_2_subtitle.tr(),
        ),
      ].addSeparator(const SizedBox(height: 20)),
    );
  }

  Widget _featureRow({required IconData icon, required String title, required String subtitle}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 30,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.textTheme.headlineMedium,
              ),
              Text(
                subtitle,
                style: context.textTheme.bodyLarge?.copyWith(color: context.color.secondaryText),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
