import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/purchasing/paywalls/paywall_page.dart';
import 'package:smart_timer/services/timer_couter_service.dart';

import '../purchasing/premium_state.dart';

class StartButton extends StatelessWidget {
  const StartButton({Key? key, required this.onPressed, this.backgroundColor}) : super(key: key);
  final VoidCallback onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonTheme(
      data: context.buttonThemes.startButtonTheme,
      child: Padding(
        padding: const EdgeInsets.only(right: 30),
        child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(backgroundColor)),
          onPressed: () {
            final premiumState = context.read<PremiumState>();
            if (premiumState.isPremiumActive || TimerCouterService().canStartNewTimer) {
              onPressed();
            } else {
              PaywallPage.show(context);
            }
          },
          child: Text(LocaleKeys.start.tr()),
        ),
      ),
    );
  }
}
