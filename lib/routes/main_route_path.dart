import 'package:smart_timer/models/workout.dart';

/// Class is having all parameters decoded from path
class MainRoutePath {
  MainRoutePath(this.pages);

  factory MainRoutePath.loading() => MainRoutePath([const SplashPageData()]);
  factory MainRoutePath.main() => MainRoutePath([const MainPageData()]);
  factory MainRoutePath.tabataSettigs() => MainRoutePath([const TabataSettigsPageData()]);
  factory MainRoutePath.tabataTimer() => MainRoutePath([const TabataSettigsPageData()]);

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
  tabataSettings,
  emomSettings,
  amrapSettings,
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
    PageType.tabataSettings: 'tabataSettings',
    PageType.emomSettings: 'emomSettings',
    PageType.amrapSettings: 'amrapSettings',
    PageType.timer: 'tabataTimer',
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

class TabataSettigsPageData extends PageData {
  const TabataSettigsPageData() : super();

  @override
  PageType get type => PageType.tabataSettings;
}

class EmomSettigsPageData extends PageData {
  const EmomSettigsPageData() : super();

  @override
  PageType get type => PageType.emomSettings;
}

class AmrapSettigsPageData extends PageData {
  const AmrapSettigsPageData() : super();

  @override
  PageType get type => PageType.amrapSettings;
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
