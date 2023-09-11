import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_timer/analytics/analytics_manager.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/purchasing/paywalls/paywall_page.dart';
import 'package:smart_timer/services/timer_couter_service.dart';
import 'package:smart_timer/utils/string_utils.dart';
import 'package:smart_timer/widgets/adaptive_alert.dart';

import '../purchasing/adapty_profile_state.dart';

class StartButton extends StatelessWidget {
  const StartButton({
    Key? key,
    required this.onPressed,
    this.backgroundColor,
    this.totalTime,
  }) : super(key: key);
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Duration? totalTime;

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonTheme(
      data: context.buttonThemes.startButtonTheme,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(backgroundColor)),
        onPressed: () async {
          final premiumState = context.read<AdaptyProfileState>();
          AnalyticsManager.eventSetupPageStartPressed
              .setProperty('rest_of_launches', TimerCouterService.maxFreeTimerADay - TimerCouterService().todaysCount)
              .setProperty('max_launches', TimerCouterService.maxFreeTimerADay)
              .commit();

          if (premiumState.isPremiumActive || TimerCouterService().canStartNewTimer) {
            onPressed();
          } else {
            await AdaptiveDialog.show(
              context,
              title: LocaleKeys.limit_reached_alert_title.tr(),
              content:
                  LocaleKeys.limit_reached_alert_content.tr(args: [TimerCouterService.maxFreeTimerADay.toString()]),
              actions: [
                DialogAction(
                  actionTitle: LocaleKeys.limit_reached_alert_button_title.tr(),
                  onPressed: Navigator.of(context).pop,
                ),
              ],
            );
            // ignore: use_build_context_synchronously
            final hasPremium = await PaywallPage.show(context) ?? false;
            if (hasPremium) {
              onPressed();
            }
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(LocaleKeys.start.tr()),
            if (totalTime != null)
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child:
                    Text('${LocaleKeys.total.tr()}: ${totalTime!.readableString}', style: context.textTheme.bodyMedium),
              ),
          ],
        ),
      ),
    );
  }
}
