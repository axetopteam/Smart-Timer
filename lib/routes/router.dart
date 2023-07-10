// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_timer/settings/settings_page.dart';
import 'package:smart_timer/timer/timer_state.dart';
import 'package:smart_timer/timer_types/afap/afap_page.dart';
import 'package:smart_timer/timer_types/amrap/amrap_page.dart';
import 'package:smart_timer/timer_types/emom/emom_page.dart';
import 'package:smart_timer/pages/main_page.dart';
import 'package:smart_timer/timer_types/tabata/tabata_page.dart';
import 'package:smart_timer/timer/timer_page.dart';
import 'package:smart_timer/timer_types/work_rest/work_rest_page.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: MainRoute.page),
        AutoRoute(path: '/amrap', page: AmrapRoute.page),
        AutoRoute(path: '/afap', page: AfapRoute.page),
        AutoRoute(path: '/emom', page: EmomRoute.page),
        AutoRoute(path: '/tabata', page: TabataRoute.page),
        AutoRoute(path: '/workRest', page: WorkRestRoute.page),
        AutoRoute(path: '/timer', page: TimerRoute.page),
        AutoRoute(path: '/settings', page: SettingsRoute.page),
      ];
}
