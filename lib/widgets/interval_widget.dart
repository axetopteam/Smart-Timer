import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_timer/core/app_theme/app_theme.dart';
import 'package:smart_timer/utils/string_utils.dart';
import 'package:smart_timer/widgets/value_container.dart';

class IntervalWidget extends StatelessWidget {
  const IntervalWidget({
    Key? key,
    required this.title,
    required this.duration,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final Duration duration;
  final VoidCallback onTap;

  AppTheme get theme => GetIt.I<AppTheme>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.bodyText2,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: ValueContainer(
            durationToString2(duration),
            width: 150,
          ),
        )
      ],
    );
  }
}
