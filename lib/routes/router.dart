import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_timer/UI/add_new_timer.dart/new_timer_page.dart';
import 'package:smart_timer/UI/add_new_timer.dart/new_timer_router.dart';
import 'package:smart_timer/UI/history/workout_details_page.dart';
import 'package:smart_timer/UI/intro/intro_page.dart';
import 'package:smart_timer/UI/main_page/main_page.dart';
import 'package:smart_timer/UI/paywalls/paywall_page.dart';
import 'package:smart_timer/UI/settings/settings_page.dart';
import 'package:smart_timer/UI/timer/timer_page.dart';
import 'package:smart_timer/UI/timer_types/afap/afap_page.dart';
import 'package:smart_timer/UI/timer_types/amrap/amrap_page.dart';
import 'package:smart_timer/UI/timer_types/emom/emom_page.dart';
import 'package:smart_timer/UI/timer_types/tabata/tabata_page.dart';
import 'package:smart_timer/UI/timer_types/timer_settings_interface.dart';
import 'package:smart_timer/UI/timer_types/work_rest/work_rest_page.dart';
import 'package:smart_timer/UI/workouts/workouts_page.dart';
import 'package:smart_timer/UI/workouts/workouts_tab.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/intro',
          page: IntroRoute.page,
        ),
        AutoRoute(
          path: '/main',
          page: MainRoute.page,
          children: [
            AutoRoute(
              path: 'newTimerRouter',
              page: NewTimerRouter.page,
              children: [
                AutoRoute(initial: true, path: 'newTimer', page: NewTimerRoute.page),
              ],
            ),
            AutoRoute(path: 'settings', page: SettingsRoute.page),
            AutoRoute(
              path: 'workoutsTab',
              page: WorkoutsRouter.page,
              children: [
                AutoRoute(initial: true, path: 'workouts', page: WorkoutsRoute.page),
              ],
            ),
          ],
        ),
        AutoRoute(path: '/workoutDetails', page: WorkoutDetailsRoute.page),
        AutoRoute(path: '/amrap', page: AmrapRoute.page),
        AutoRoute(path: '/afap', page: AfapRoute.page),
        AutoRoute(path: '/emom', page: EmomRoute.page),
        AutoRoute(path: '/tabata', page: TabataRoute.page),
        AutoRoute(path: '/workRest', page: WorkRestRoute.page),
        AutoRoute(path: '/timer', page: TimerRoute.page),
        CustomRoute(
          page: PaywallRoute.page,
          customRouteBuilder: popupBuilder,
        )
      ];
}

Route<T> popupBuilder<T>(
  BuildContext context,
  Widget child,
  AutoRoutePage<T> page, {
  bool canClose = true,
}) {
  return CupertinoModalPopupRoute<T>(
    builder: (ctx) => child,
    barrierColor: CupertinoDynamicColor.resolve(kCupertinoModalBarrierColor, context),
    barrierDismissible: canClose,
    semanticsDismissible: false,
    settings: page,
  );
}
