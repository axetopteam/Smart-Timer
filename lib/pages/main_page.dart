import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/routes/router.dart';
import 'package:smart_timer/timer/timer_type.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          icon: const Icon(CupertinoIcons.settings),
          onPressed: () {
            context.router.push(const SettingsRoute());
          },
        ),
      ]),
      resizeToAvoidBottomInset: false,
      body: Material(
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text(
                    'EASY\nTIMER',
                    style: context.textTheme.displayLarge,
                  ),
                ),
                const Spacer(),
                Wrap(
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.center,
                  direction: Axis.horizontal,
                  runSpacing: 15,
                  spacing: 10,
                  verticalDirection: VerticalDirection.down,
                  children: [
                    buildContainer(
                      context: context,
                      title: TimerType.amrap.readbleName.toUpperCase(),
                      color: context.color.amrapColor,
                      onTap: () {
                        context.router.push(const AmrapRoute());
                      },
                    ),
                    buildContainer(
                      context: context,
                      title: TimerType.afap.readbleName.toUpperCase(),
                      color: context.color.afapColor,
                      onTap: () {
                        context.router.push(const AfapRoute());
                      },
                    ),
                    buildContainer(
                      context: context,
                      title: TimerType.emom.readbleName.toUpperCase(),
                      color: context.color.emomColor,
                      onTap: () {
                        context.router.push(const EmomRoute());
                      },
                    ),
                    buildContainer(
                      context: context,
                      title: TimerType.tabata.readbleName.toUpperCase(),
                      color: context.color.tabataColor,
                      onTap: () {
                        context.router.push(const TabataRoute());
                      },
                    ),
                    buildContainer(
                      context: context,
                      title: TimerType.workRest.readbleName.toUpperCase(),
                      color: context.color.workRestColor,
                      onTap: () {
                        context.router.push(const WorkRestRoute());
                      },
                    ),
                    // buildContainer(
                    //   context: context,
                    //   title: TimerType.custom.readbleName.toUpperCase(),
                    //   color: context.color.customColor,
                    //   onTap: () {
                    //     context.router.push(const CustomizedRoute());
                    //   },
                    // ),
                  ],
                ),
                const SizedBox(height: 56),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContainer({
    required BuildContext context,
    required Color color,
    required String title,
    required void Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Text(title),
        labelStyle: context.textTheme.displayMedium,
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
