import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/routes/router.dart';
import 'package:smart_timer/timer/timer_type.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amberAccent,
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 168),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Text(
                  'EASY\nTIMER',
                  style: context.textTheme.headline1,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  buildContainer(
                    context: context,
                    title: TimerType.amrap.readbleName.toUpperCase(),
                    color: context.color.amrapColor,
                    onPressed: () {
                      context.router.push(const AmrapRoute());
                    },
                  ),
                  const SizedBox(width: 10),
                  buildContainer(
                    context: context,
                    title: TimerType.afap.readbleName.toUpperCase(),
                    color: context.color.afapColor,
                    onPressed: () {
                      context.router.push(const AfapRoute());
                    },
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  buildContainer(
                    context: context,
                    title: TimerType.emom.readbleName.toUpperCase(),
                    color: context.color.emomColor,
                    onPressed: () {
                      context.router.push(const EmomRoute());
                    },
                  ),
                  const SizedBox(width: 10),
                  buildContainer(
                    context: context,
                    title: TimerType.workRest.readbleName.toUpperCase(),
                    color: context.color.workRestColor,
                    onPressed: () {
                      context.router.push(const WorkRestRoute());
                    },
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  buildContainer(
                    context: context,
                    title: TimerType.tabata.readbleName.toUpperCase(),
                    color: context.color.tabataColor,
                    onPressed: () {
                      context.router.push(const TabataRoute());
                    },
                  ),
                  const SizedBox(width: 10),
                  buildContainer(
                    context: context,
                    title: TimerType.custom.readbleName.toUpperCase(),
                    color: context.color.customColor,
                    onPressed: () {
                      context.router.push(const CustomizedRoute());
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContainer({
    required BuildContext context,
    required Color color,
    required String title,
    Function? onPressed,
  }) {
    return GestureDetector(
      onTap: () => onPressed?.call(),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          title,
          style: context.textTheme.headline2,
        ),
      ),
    );
  }
}
