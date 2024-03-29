import 'dart:math';

import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:smart_timer/UI/widgets/adaptive_alert.dart';
import 'package:smart_timer/UI/widgets/purchase_error_alert.dart';
import 'package:smart_timer/analytics/analytics_manager.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/purchasing/adapty_profile_state.dart';
import 'package:smart_timer/utils/interable_extension.dart';
import 'package:smart_timer/utils/utils.dart';

import 'paywall_state.dart';
import 'product_container.dart';

@RoutePage<bool>()
class PaywallPage extends StatefulWidget {
  const PaywallPage({super.key});

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
          AnalyticsManager.eventPaywallClosed.setProperty('premium_activated', 'false').commit();
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop(false);
        }
      },
    );

    _makePurchaseReactionDisposer = reaction<PurchaseResult?>(
      (_) => state.purchaseResult,
      (purchaseResult) {
        switch (purchaseResult?.type) {
          case PurchaseResultType.success:
            AnalyticsManager.eventPaywallClosed.setProperty('premium_activated', 'true').commit();
            final profile = purchaseResult?.profile;
            if (profile != null) {
              context.read<AdaptyProfileState>().updatePremiumStatus(profile);
            }
            Navigator.of(context).pop(true);
          case PurchaseResultType.fail:
            PurchaseErrorAlert.showPurchaseError(context,
                errorCode: purchaseResult?.errorCode, message: purchaseResult?.message);
          case PurchaseResultType.restoreFail:
            PurchaseErrorAlert.showRestoreError(context,
                errorCode: purchaseResult?.errorCode, message: purchaseResult?.message);
          default:
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
                    SizedBox(height: safeOffset.top + 40),
                    Text(
                      LocaleKeys.paywall_title.tr(),
                      style: context.textTheme.titleSmall,
                    ),
                    Text(
                      LocaleKeys.app_name.tr(),
                      style: context.textTheme.titleSmall?.copyWith(fontSize: 30, color: context.theme.primaryColor),
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
      right: 20,
      child: IconButton(
        onPressed: () {
          AnalyticsManager.eventPaywallClosed.setProperty('premium_activated', 'false').commit();
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
        padding: EdgeInsets.fromLTRB(20, 0, 20, max(safeOffset.bottom, 20)),
        decoration: BoxDecoration(
          color: context.color.background,
          boxShadow: [
            BoxShadow(
              color: context.color.shadow,
              blurRadius: 4,
              offset: const Offset(0, -4),
              spreadRadius: -4,
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
                  onPressed: selectedProduct != null
                      ? () {
                          AnalyticsManager.eventPaywallPurchaseButtonPressed
                              .setProperty('product_id', selectedProduct.vendorProductId)
                              .commit();
                          state.makePurchase(selectedProduct);
                        }
                      : null,
                  child: Container(
                    width: double.maxFinite,
                    alignment: Alignment.center,
                    child: Text(LocaleKeys.paywall_bottom_block_button_title.tr()),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButtonTheme(
              data: TextButtonThemeData(
                style: context.theme.textButtonTheme.style?.copyWith(
                  foregroundColor: MaterialStatePropertyAll(context.color.secondaryText),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  runSpacing: 4,
                  spacing: 8,
                  children: [
                    TextButton(
                      onPressed: AppUtils.openTermsOfUse,
                      child: Text(
                        LocaleKeys.paywall_bottom_block_terms.tr(),
                        style: context.textStyles.footer,
                      ),
                    ),
                    TextButton(
                      onPressed: state.restorePurchase,
                      child: Text(
                        LocaleKeys.paywall_bottom_block_restore.tr(),
                        style: context.textStyles.footer,
                      ),
                    ),
                    TextButton(
                      onPressed: AppUtils.openPrivacyPolicy,
                      child: Text(
                        LocaleKeys.paywall_bottom_block_privacy.tr(),
                        style: context.textStyles.footer,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Column(
            //   children: [
            //     Row(
            //       // mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: [
            //         Expanded(
            //           child: TextButton(
            //             style: ButtonStyle(foregroundColor: MaterialStatePropertyAll(context.color.secondaryText)),
            //             onPressed: AppUtils.openTermsOfUse,
            //             child: Text(LocaleKeys.paywall_bottom_block_terms.tr()),
            //           ),
            //         ),
            //         Expanded(
            //           child: TextButton(
            //             style: ButtonStyle(foregroundColor: MaterialStatePropertyAll(context.color.secondaryText)),
            //             onPressed: AppUtils.openPrivacyPolicy,
            //             child: Text(LocaleKeys.paywall_bottom_block_privacy.tr()),
            //           ),
            //         ),
            //       ],
            //     ),
            //     const SizedBox(height: 4),
            //     TextButton(
            //       style: ButtonStyle(foregroundColor: MaterialStatePropertyAll(context.color.secondaryText)),
            //       onPressed: state.restorePurchase,
            //       child: Text(LocaleKeys.paywall_bottom_block_restore.tr()),
            //     ),
            //   ],
            // ),
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
        ),
        _featureRow(
          icon: CupertinoIcons.nosign,
          title: LocaleKeys.paywall_features_2_title.tr(),
        ),
        _featureRow(
          icon: CupertinoIcons.heart,
          title: LocaleKeys.paywall_features_3_title.tr(),
        ),
      ].addSeparator(const SizedBox(height: 20)),
    );
  }

  Widget _featureRow({required IconData icon, required String title, String? subtitle}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
              if (subtitle != null)
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
