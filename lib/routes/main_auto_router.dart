// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
import 'package:auto_route/auto_route.dart';
import 'package:smart_timer/timers/afap/afap_page.dart';
import 'package:smart_timer/timers/amrap/amrap_page.dart';
import 'package:smart_timer/timers/custom/customized_page.dart';
import 'package:smart_timer/timers/emom/emom_page.dart';
import 'package:smart_timer/pages/main_page.dart';
import 'package:smart_timer/timers/tabata/tabata_page.dart';
import 'package:smart_timer/pages/timer_page.dart';
import 'package:smart_timer/timers/work_rest/work_rest_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: MainPage, initial: true),
    AutoRoute(page: AmrapPage),
    AutoRoute(page: AfapPage),
    AutoRoute(page: EmomPage),
    AutoRoute(page: TabataPage),
    AutoRoute(page: WorkRestPage),
    AutoRoute(page: CustomizedPage),
    AutoRoute(page: TimerPage),

    // AutoRoute(page: BookDetailsPage),
  ],
)
class $AppRouter {}
