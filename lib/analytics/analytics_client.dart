import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

abstract class AnalyticsClient {
  Future<bool> initialize();

  void setUserId(String? userId);

  void setUserProperty(String propertyId, dynamic value);

  void logEvent(String eventId, Map<String, dynamic> properties);
}

class DebugAnalyticsClient implements AnalyticsClient {
  @override
  Future<bool> initialize() {
    return Future<bool>.value(true);
  }

  @override
  void setUserId(String? userId) {
    debugPrint('#DebugAnalyticsClient# set user id: $userId');
  }

  @override
  void setUserProperty(String propertyId, dynamic value) {
    debugPrint('#DebugAnalyticsClient# set $propertyId = $value');
  }

  @override
  void logEvent(String eventId, Map<String, dynamic> properties) {
    debugPrint('#DebugAnalyticsClient# log $eventId $properties');
  }
}

class FirebaseClient implements AnalyticsClient {
  FirebaseClient();

  final FirebaseAnalytics _firebaseClient = FirebaseAnalytics.instance;

  @override
  void setUserId(String? userId) {
    _firebaseClient.setUserId(id: userId);
  }

  @override
  void setUserProperty(String propertyId, dynamic value) {
    _firebaseClient.setUserProperty(name: propertyId, value: value);
  }

  @override
  void logEvent(String eventId, Map<String, dynamic> properties) {
    _firebaseClient.logEvent(name: eventId, parameters: properties);
  }

  @override
  Future<bool> initialize() async {
    return Future<bool>.value(true);
  }
}

class MixPanelClient implements AnalyticsClient {
  MixPanelClient(this.apiKey);

  final String apiKey;
  late final Mixpanel _mixpanelClient;
  People? user;

  @override
  Future<bool> initialize() async {
    _mixpanelClient = await Mixpanel.init(apiKey, trackAutomaticEvents: true);
    return true;
  }

  @override
  void setUserId(String? id) {
    if (id != null) {
      user = People(id);
      _mixpanelClient.identify(id);
    }
  }

  @override
  void setUserProperty(String propertyId, dynamic value) {
    user?.setOnce(propertyId, value);
  }

  @override
  void logEvent(String eventId, Map<String, dynamic> properties) {
    _mixpanelClient.track(eventId, properties: properties);
  }
}
