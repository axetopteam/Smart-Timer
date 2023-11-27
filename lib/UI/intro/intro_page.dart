import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:smart_timer/UI/timer/timer_type.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/utils/interable_extension.dart';

@RoutePage<void>()
class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      headerBackgroundColor: context.color.background,
      finishButtonText: 'Начать',
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: context.color.accent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
      ),
      skipTextButton: Text(
        'Skip',
        style: context.textTheme.bodySmall,
      ),
      background: [
        ColoredBox(color: context.color.background),
        ColoredBox(color: context.color.background),
      ],
      totalPage: 2,
      speed: 1.8,
      pageBodies: const [
        IntroPage1(),
        IntroPage2(),
      ],
    );
  }
}

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Text(
            "Основные режимы",
            style: context.textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ...TimerType.values
              .map(
                (e) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      CupertinoIcons.timer,
                      color: e.workoutColor(context),
                      size: 30,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.readbleName),
                          Text(e.readbleDescription),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              .addSeparator(SizedBox(
                height: 16,
              )),
        ],
      ),
    );
  }
}

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20),
          Text(
            "Welcome to Easy Timer\nYour Ultimate Workout Companion!",
            style: context.textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Icon(
            CupertinoIcons.timer_fill,
            size: 36,
          ),
          const SizedBox(height: 12),
          Text(
            "Настраивайте таймер индивидуально под ваши тренировки",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Icon(
            CupertinoIcons.heart_fill,
            size: 36,
          ),
          const SizedBox(height: 12),
          Text(
            'Добайляйте тренировки в избранные, чтобы иметь к ним быстрый доступ',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Icon(
            CupertinoIcons.graph_circle_fill,
            size: 36,
          ),
          const SizedBox(height: 12),
          Text(
            'Все ваши тренировки сохраняются, чтобы вы могли легко отслеживать свой прогресс',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
