// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
import 'package:auto_route/auto_route.dart';
import 'package:smart_timer/pages/afap_page.dart';
import 'package:smart_timer/pages/amrap_page.dart';
import 'package:smart_timer/pages/custom_settings_page.dart';
import 'package:smart_timer/pages/emom_page.dart';
import 'package:smart_timer/pages/main_page.dart';
import 'package:smart_timer/pages/tabata_page.dart';
import 'package:smart_timer/pages/timer_page.dart';
import 'package:smart_timer/pages/work_rest_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: MainPage, initial: true),
    AutoRoute(page: AmrapPage),
    AutoRoute(page: AfapPage),
    AutoRoute(page: EmomPage),
    AutoRoute(page: TabataPage),
    AutoRoute(page: WorkRestPage),
    AutoRoute(page: CustomSettingsPage),
    AutoRoute(page: TimerPage),

    // AutoRoute(page: BookDetailsPage),
  ],
)
class $AppRouter {}
