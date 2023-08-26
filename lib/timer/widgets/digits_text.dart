import 'package:flutter/cupertino.dart';
import 'package:smart_timer/core/context_extension.dart';

class DigitsText extends StatelessWidget {
  const DigitsText(this.digits, {super.key});

  final String digits;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: digits
          .split('')
          .map((digit) => Container(
                alignment: Alignment.center,
                width: 50,
                child: Text(
                  digit,
                  style: context.textTheme.headlineSmall,
                ),
              ))
          .toList(),
    );
  }
}
