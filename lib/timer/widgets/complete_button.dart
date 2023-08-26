import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/widgets/swipe_button/slider_button.dart';

class CompleteButton extends StatelessWidget {
  const CompleteButton({
    required this.action,
    required this.iconColor,
    super.key,
  });

  final Function action;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return SliderButton(
      backgroundColor: Colors.white30,
      label: Text(
        LocaleKeys.timer_complete_round.tr(),
        style: context.textTheme.bodyLarge,
      ),
      height: 50,
      buttonSize: 40,
      alignLabel: const Alignment(0.2, 0),
      shimmer: true,
      highlightedColor: context.color.secondaryText,
      baseColor: context.color.mainText,
      action: action,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: context.color.playIconColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          CupertinoIcons.arrow_right,
          color: iconColor,
        ),
      ),
    );
  }
}
