import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:smart_timer/analytics/analytics_manager.dart';
import 'package:smart_timer/UI/bottom_sheets/seconds_picker/seconds_picker.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/purchasing/adapty_profile_state.dart';
import 'package:smart_timer/services/app_review_service.dart';
import 'package:smart_timer/utils/utils.dart';

import '../paywalls/paywall_page.dart';
import '../widgets/purchase_error_alert.dart';
import 'settings_state.dart';
import 'support.dart/application_support.dart';

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _state = SettingsState();
  late final AdaptyProfileState adaptyProfileState;

  @override
  void initState() {
    adaptyProfileState = context.read<AdaptyProfileState>();
    AnalyticsManager.eventSettingsOpened.commit();
    super.initState();
  }

  @override
  void dispose() {
    AnalyticsManager.eventSettingsClosed.commit();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: Text(LocaleKeys.settings_title.tr()),
          heroTag: 'settings',
        ),
        _generalBlock(),
        _planBlock(),
        _timerBlock(),
        _legalBlock(),
        _appInfo(),
        SliverToBoxAdapter(child: SizedBox(height: bottomPadding + 20)),
      ],
    );
  }

  Widget _generalBlock() {
    return SliverToBoxAdapter(
      child: CupertinoListSection.insetGrouped(
        backgroundColor: context.color.background,
        header: Text(
          LocaleKeys.settings_general.tr().toUpperCase(),
          style: context.textTheme.titleMedium?.copyWith(color: context.color.secondaryText),
        ),
        margin: const EdgeInsets.fromLTRB(20, 4, 20, 20),
        decoration: BoxDecoration(
          color: context.color.containerBackground,
        ),
        children: [
          CupertinoListTile.notched(
            title: Text(LocaleKeys.settings_rate_us.tr()),
            leading: const Icon(CupertinoIcons.star_fill),
            onTap: () {
              AnalyticsManager.eventSettingsRateUsPressed.commit();
              AppReviewService().openStoreListing();
            },
          ),
          CupertinoListTile.notched(
            title: Text(LocaleKeys.settings_contact_us.tr()),
            leading: const Icon(CupertinoIcons.at),
            onTap: () {
              AnalyticsManager.eventSettingsContactUsPressed.commit();
              ApplicationSupport.showSupportDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _planBlock() {
    return SliverToBoxAdapter(
      child: Observer(builder: (context) {
        final isActive = adaptyProfileState.profile?.hasPremium ?? false;
        return CupertinoListSection.insetGrouped(
          backgroundColor: context.color.background,
          header: Text(
            LocaleKeys.settings_plan_title.tr().toUpperCase(),
            style: context.textTheme.titleMedium?.copyWith(color: context.color.secondaryText),
          ),
          margin: const EdgeInsets.fromLTRB(20, 4, 20, 20),
          decoration: BoxDecoration(
            color: context.color.containerBackground,
          ),
          children: [
            if (!adaptyProfileState.isPremiumActive)
              CupertinoListTile.notched(
                title: Text(LocaleKeys.settings_plan_purchase.tr()),
                leading: const Icon(CupertinoIcons.star_circle_fill),
                onTap: () {
                  AnalyticsManager.eventSettingsPurchasePressed.commit();
                  PaywallPage.show(context);
                },
              ),
            CupertinoListTile.notched(
              title: Text(LocaleKeys.settings_plan_title.tr()),
              leading: const Icon(CupertinoIcons.checkmark_seal),
              trailing: Container(
                padding: const EdgeInsets.fromLTRB(6, 2, 6, 4),
                decoration: BoxDecoration(
                  color: adaptyProfileState.isPremiumActive ? context.color.premium : context.color.warning,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: isActive
                    ? Text(LocaleKeys.settings_plan_active.tr())
                    : Text(LocaleKeys.settings_plan_inactive.tr()),
              ),
            ),
            Observer(builder: (context) {
              return CupertinoListTile.notched(
                title: Text(LocaleKeys.settings_plan_restore.tr()),
                leading: const Icon(Icons.cloud_download),
                onTap: _state.purchaseInProgress ? null : _restore,
                trailing: _state.purchaseInProgress ? const CupertinoActivityIndicator() : null,
              );
            }),
          ],
        );
      }),
    );
  }

  Future<void> _restore() async {
    final purchaseResult = await _state.restorePurchase();
    if (purchaseResult?.type == PurchaseResultType.success) {
      final profile = purchaseResult?.profile;
      if (profile != null) {
        adaptyProfileState.updatePremiumStatus(profile);
      }
    }
    if (purchaseResult?.type == PurchaseResultType.restoreFail) {
      // ignore: use_build_context_synchronously
      await PurchaseErrorAlert.showRestoreError(context,
          errorCode: purchaseResult?.errorCode, message: purchaseResult?.message);
    }
  }

  Widget _timerBlock() {
    return SliverToBoxAdapter(
      child: CupertinoListSection.insetGrouped(
        header: Text(
          LocaleKeys.settings_timer.tr().toUpperCase(),
          style: context.textTheme.titleMedium?.copyWith(color: context.color.secondaryText),
        ),
        backgroundColor: context.color.background,
        margin: const EdgeInsets.fromLTRB(20, 4, 20, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.color.containerBackground,
        ),
        children: [
          CupertinoListTile.notched(
            title: Text(LocaleKeys.settings_sound_on.tr()),
            leading: const Icon(CupertinoIcons.speaker_3_fill),
            trailing: Observer(
              builder: (context) {
                final soundOn = _state.soundOn;
                if (soundOn != null) {
                  return CupertinoSwitch(
                    value: soundOn,
                    applyTheme: true,
                    onChanged: (value) {
                      _state.saveSoundOn(value);
                      AnalyticsManager.eventSettingsSoundSwitched.setProperty('on', value.toString()).commit();
                    },
                  );
                } else {
                  return const CupertinoActivityIndicator();
                }
              },
            ),
          ),
          CupertinoListTile.notched(
            title: Text(LocaleKeys.settings_countdown.tr()),
            leading: const Icon(CupertinoIcons.gobackward_10),
            trailing: Observer(
              builder: (context) {
                return TextButton(
                  child: Text('${_state.countdownSeconds} ${LocaleKeys.second_short.tr()}'),
                  onPressed: () async {
                    final selectedValue = await SecondsPicker.show(
                      context,
                      title: LocaleKeys.settings_countdown.tr(),
                      initialValue: _state.countdownSeconds,
                      range: SecondsPicker.countdownSecondsList,
                    );
                    if (selectedValue != null) {
                      _state.saveCountdownSeconds(selectedValue);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _legalBlock() {
    return SliverToBoxAdapter(
      child: CupertinoListSection.insetGrouped(
        header: Text(
          LocaleKeys.settings_legal.tr().toUpperCase(),
          style: context.textTheme.titleMedium?.copyWith(color: context.color.secondaryText),
        ),
        backgroundColor: context.color.background,
        margin: const EdgeInsets.fromLTRB(20, 4, 20, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.color.containerBackground,
        ),
        children: [
          CupertinoListTile.notched(
            title: Text(LocaleKeys.settings_privacy_policy.tr()),
            leading: const Icon(CupertinoIcons.checkmark_shield_fill),
            onTap: AppUtils.openPrivacyPolicy,
          ),
          CupertinoListTile.notched(
            title: Text(LocaleKeys.settings_terms_of_use.tr()),
            leading: const Icon(CupertinoIcons.doc_plaintext),
            onTap: AppUtils.openTermsOfUse,
          ),
        ],
      ),
    );
  }

  Widget _appInfo() {
    return SliverToBoxAdapter(
      child: FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              final version = snapshot.data?.version ?? '';
              final buildNumber = snapshot.data?.buildNumber ?? '';
              return Align(
                alignment: Alignment.center,
                child: Text(
                  '${LocaleKeys.settings_version.tr()} $version.$buildNumber',
                ),
              );
            }
            return Container();
          }),
    );
  }
}
