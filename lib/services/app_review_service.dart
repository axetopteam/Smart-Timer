import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:smart_timer/services/app_properties.dart';

/// AppReviewService singleton class
class AppReviewService {
  static final AppReviewService _internalSingleton = AppReviewService._internal();
  factory AppReviewService() => _internalSingleton;
  AppReviewService._internal();

  final inAppReview = InAppReview.instance;

  Future<void> requestReviewIfAvailable() async {
    final params = AppProperties().rateSuggestionShowParams;
    if (params.date == null) {
      if (await inAppReview.isAvailable()) {
        final packageInfo = await PackageInfo.fromPlatform();

        final version = packageInfo.version;
        AppProperties().rateSuggestionShowedParams(DateTime.now(), version);
        await inAppReview.requestReview();
      }
    }
  }

  Future<void> openStoreListing() async {
    await inAppReview.openStoreListing(appStoreId: '1591016238');
  }
}
