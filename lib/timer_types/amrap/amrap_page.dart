import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:smart_timer/bottom_sheets/time_picker/time_picker.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/routes/router.dart';
import 'package:smart_timer/services/app_properties.dart';
import 'package:smart_timer/timer/timer_state.dart';
import 'package:smart_timer/timer/timer_type.dart';
import 'package:smart_timer/widgets/interval_widget.dart';
import 'package:smart_timer/widgets/timer_setup_scaffold.dart';

import 'amrap_state.dart';

@RoutePage()
class AmrapPage extends StatefulWidget {
  const AmrapPage({Key? key}) : super(key: key);

  @override
  State<AmrapPage> createState() => _AmrapPageState();
}

class _AmrapPageState extends State<AmrapPage> {
  late final AmrapState amrapState;

  @override
  void initState() {
    final json = AppProperties().getAmrapSettings();
    amrapState = json != null ? AmrapState.fromJson(json) : AmrapState();

    super.initState();
  }

  @override
  void dispose() {
    final json = amrapState.toJson();
    AppProperties().setAmrapSettings(json);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TimerSetupScaffold(
      color: context.color.amrapColor,
      appBarTitle: LocaleKeys.amrap_title.tr(),
      subtitle: LocaleKeys.amrap_description.tr(),
      onStartPressed: () => context.router.push(
        TimerRoute(
          state: TimerState(
            workout: amrapState.workout,
            timerType: TimerType.amrap,
          ),
        ),
      ),
      slivers: [
        Observer(
          builder: (context) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, index) {
                  return _buildAmrap(index);
                },
                childCount: amrapState.amrapsCount,
              ),
            );
          },
        ),
        SliverPadding(
          padding: const EdgeInsets.only(top: 26),
          sliver: SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton(
              onPressed: amrapState.addAmrap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add_circle_outline, size: 20),
                  const SizedBox(width: 4),
                  Text(LocaleKeys.amrap_add_button_title.tr())
                ],
              ),
            ),
          )),
        ),
      ],
    );
  }

  Widget _buildAmrap(int amrapIndex) {
    return Observer(
      builder: (context) {
        final amrap = amrapState.amraps[amrapIndex];
        bool isLast = amrapIndex == amrapState.amrapsCount - 1;

        return Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${LocaleKeys.amrap_title.tr()} ${amrapIndex + 1}',
                    style: context.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntervalWidget(
                          title: LocaleKeys.work_time.tr(),
                          duration: amrap.workTime,
                          onTap: () async {
                            final selectedTime = await TimePicker.showTimePicker(
                              context,
                              initialDuration: amrap.workTime,
                            );
                            if (selectedTime != null) {
                              amrapState.setWorkTime(amrapIndex, selectedTime);
                            }
                          }),
                      if (!isLast) const SizedBox(width: 10),
                      if (!isLast)
                        IntervalWidget(
                          title: LocaleKeys.rest_time.tr(),
                          duration: amrap.restTime,
                          canBeUnlimited: false,
                          onTap: () async {
                            final selectedTime = await TimePicker.showTimePicker(
                              context,
                              initialDuration: amrap.restTime,
                            );
                            if (selectedTime != null) {
                              amrapState.setRestTime(amrapIndex, selectedTime);
                            }
                          },
                        ),
                    ],
                  ),
                  if (amrapState.amrapsCount > 1)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          TextButtonTheme(
                            data: context.buttonThemes.deleteButtonTheme,
                            child: TextButton(
                              onPressed: () {
                                amrapState.deleteAmrap(amrapIndex);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    LocaleKeys.amrap_delete_button_title.tr(args: ['${amrapIndex + 1}']),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const Divider(thickness: 5, height: 5),
          ],
        );
      },
    );
  }
}
