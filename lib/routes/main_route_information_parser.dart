import 'package:flutter/cupertino.dart';

import 'main_route_path.dart';

class MainRouteInformationParser extends RouteInformationParser<MainRoutePath> {
  @override
  Future<MainRoutePath> parseRouteInformation(RouteInformation routeInformation) async {
    if (routeInformation.location == null) {
      return MainRoutePath.loading();
    }

    final uri = Uri.parse(routeInformation.location!);
    final routeParts = uri.pathSegments;

    // Handle '/'
    if (routeParts.isEmpty) {
      return MainRoutePath.loading();
    }

    final pageData = <PageData>[];
    while (routeParts.isNotEmpty) {
      final pageDataItem = PageData.fromPathParts(routeParts);
      pageData.add(pageDataItem);
      if (pageDataItem is Page404PageData) {
        break;
      }
      routeParts.removeRange(0, pageDataItem.requiredPathPartsNumber);
    }
    return MainRoutePath(pageData);
  }

  @override
  RouteInformation? restoreRouteInformation(MainRoutePath configuration) => RouteInformation(location: configuration.toString());
}
