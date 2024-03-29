import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:provider/provider.dart';
import 'package:smart_timer/UI/timer/timer_type.dart';
import 'package:smart_timer/analytics/analytics_manager.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/purchasing/adapty_profile_state.dart';
import 'package:smart_timer/routes/router.dart';
import 'package:smart_timer/services/app_properties.dart';
import 'package:smart_timer/utils/interable_extension.dart';

import 'intro_state.dart';

@RoutePage<void>()
class IntroPage extends StatelessWidget {
  IntroPage({super.key});

  final IntroState state = IntroState();

  Future<void> _onFinishTap(BuildContext context) async {
    final role = state.selectedRole;
    if (role != null) {
      AnalyticsManager().setUserProperty('role', role.name);
    }

    AppProperties().setIntroShowedDateTime(DateTime.now().toUtc());

    final premiumState = context.read<AdaptyProfileState>();

    context.router.popUntil((route) => false);
    await context.router.pushAll([
      const MainRoute(),
      if (!premiumState.isPremiumActive) const PaywallRoute(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      indicatorAbove: false,
      headerBackgroundColor: context.color.background,
      finishButtonText: LocaleKeys.intro_start_button.tr(),
      finishButtonTextStyle: context.textTheme.headlineMedium!,
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: context.theme.primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
      ),
      skipTextButton: Text(
        LocaleKeys.intro_skip.tr(),
        style: context.textTheme.bodySmall,
      ),
      onFinish: () => _onFinishTap(context),
      background: [
        ColoredBox(color: context.color.background),
        ColoredBox(color: context.color.background),
        ColoredBox(color: context.color.background),
      ],
      totalPage: 3,
      speed: 1.8,
      pageBodies: [
        const IntroPage1(),
        const IntroPage2(),
        IntroPage3(introState: state),
      ],
    );
  }
}

class IntroPage3 extends StatefulWidget {
  const IntroPage3({required this.introState, super.key});
  final IntroState introState;
  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Text(
              LocaleKeys.intro_page3_title.tr(),
              style: context.textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            _buildItem(
              title: LocaleKeys.intro_page3_option2.tr(),
              isSelected: widget.introState.selectedRole == RoleOption.coach,
              onTap: () {
                widget.introState.selectRole(RoleOption.coach);
              },
            ),
            const SizedBox(height: 20),
            _buildItem(
              title: LocaleKeys.intro_page3_option1.tr(),
              isSelected: widget.introState.selectedRole == RoleOption.onMyOwn,
              onTap: () {
                widget.introState.selectRole(RoleOption.onMyOwn);
              },
            ),
            const Spacer(),
            const SizedBox(height: 60),
          ],
        ),
      );
    });
  }

  Widget _buildItem({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? context.theme.primaryColor : context.color.borderColor,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          title,
          style: context.textStyles.alternativeBodyLarge,
        ),
      ),
    );
  }
}

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Text(
            LocaleKeys.intro_page2_title.tr(),
            style: context.textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
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
                          Text(
                            e.readbleName,
                            style: context.textStyles.alternativeBodyLarge.copyWith(color: e.workoutColor(context)),
                          ),
                          Text(
                            e.readbleDescription,
                            style: context.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              .addSeparator(const SizedBox(height: 16)),
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
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: context.textTheme.displaySmall,
              text: LocaleKeys.intro_page1_welcome.tr(),
              children: [
                TextSpan(text: LocaleKeys.app_name.tr(), style: TextStyle(color: context.theme.primaryColor)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            LocaleKeys.intro_page1_subtitle.tr(),
            style: context.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          const Icon(
            CupertinoIcons.timer_fill,
            size: 36,
          ),
          const SizedBox(height: 12),
          Text(
            LocaleKeys.intro_page1_feature1.tr(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Icon(
            CupertinoIcons.heart_fill,
            size: 36,
          ),
          const SizedBox(height: 12),
          Text(
            LocaleKeys.intro_page1_feature2.tr(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Icon(
            CupertinoIcons.graph_circle_fill,
            size: 36,
          ),
          const SizedBox(height: 12),
          Text(
            LocaleKeys.intro_page1_feature3.tr(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
