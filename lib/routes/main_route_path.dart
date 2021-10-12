import 'package:smart_timer/models/workout.dart';

/// Class is having all parameters decoded from path
class MainRoutePath {
  MainRoutePath(this.pages);

  factory MainRoutePath.loading() => MainRoutePath([const SplashPageData()]);
  factory MainRoutePath.main() => MainRoutePath([const MainPageData()]);

  final List<PageData> pages;

  @override
  String toString() {
    final result = StringBuffer();
    for (final page in pages) {
      result.write(page.flatPath);
    }
    return result.toString();
  }
}

enum PageType {
  splash,
  main,
  tabata,
  emom,
  amrap,
  afap,
  timer,
  page404,
}

extension PageTypePathWords on PageType {
  String get pathWord => PageData.paths[this] ?? '';
}

abstract class PageData {
  const PageData();

  factory PageData.fromPathParts(List<String> pathParts) {
    try {
      switch (_findType(pathParts.first)) {
        case PageType.splash:
          return const SplashPageData();
        case PageType.main:
          return const MainPageData();
        case PageType.page404:
        default:
          return const Page404PageData();
      }
    } catch (e) {
      return const Page404PageData();
    }
  }

  String get flatName => paths[type] ?? '';
  String get flatPath => '/$flatName';
  PageType get type;

  /// returns how many path parts are required to encode this route
  int get requiredPathPartsNumber => 1;

  static const Map<PageType, String> paths = <PageType, String>{
    PageType.splash: '',
    PageType.main: 'main',
    PageType.tabata: 'tabata',
    PageType.emom: 'emom',
    PageType.amrap: 'amrap',
    PageType.afap: 'afap',
    PageType.timer: 'timer',
    PageType.page404: 'page404',
  };

  static PageType? _findType(String pathPart) {
    for (final mapEntry in paths.entries) {
      if (mapEntry.value == pathPart) {
        return mapEntry.key;
      }
    }
    return null;
  }
}

class SplashPageData extends PageData {
  const SplashPageData() : super();

  @override
  PageType get type => PageType.splash;
}

class MainPageData extends PageData {
  const MainPageData() : super();

  @override
  PageType get type => PageType.main;
}

class TabataPageData extends PageData {
  const TabataPageData() : super();

  @override
  PageType get type => PageType.tabata;
}

class EmomPageData extends PageData {
  const EmomPageData() : super();

  @override
  PageType get type => PageType.emom;
}

class AmrapPageData extends PageData {
  const AmrapPageData() : super();

  @override
  PageType get type => PageType.amrap;
}

class AfapPageData extends PageData {
  const AfapPageData() : super();

  @override
  PageType get type => PageType.afap;
}

class TimerPageData extends PageData {
  TimerPageData(this.workout) : super();
  final Workout workout;
  @override
  PageType get type => PageType.timer;
}

class Page404PageData extends PageData {
  const Page404PageData() : super();

  @override
  PageType get type => PageType.page404;
}
