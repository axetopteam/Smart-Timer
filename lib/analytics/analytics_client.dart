import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

abstract class AnalyticsClient {
  Future<bool> initialize();

  Future<void> setUserId(String? userId);

  Future<void> setUserProperty(String propertyId, dynamic value);

  Future<void> logEvent(String eventId, Map<String, dynamic> properties);
}

class DebugAnalyticsClient implements AnalyticsClient {
  @override
  Future<bool> initialize() {
    return Future<bool>.value(true);
  }

  @override
  Future<void> setUserId(String? userId) async {
    debugPrint('#DebugAnalyticsClient# set user id: $userId');
  }

  @override
  Future<void> setUserProperty(String propertyId, dynamic value) async {
    debugPrint('#DebugAnalyticsClient# set $propertyId = $value');
  }

  @override
  Future<void> logEvent(String eventId, Map<String, dynamic> properties) async {
    debugPrint('#DebugAnalyticsClient# log $eventId $properties');
  }
}

class FirebaseClient implements AnalyticsClient {
  FirebaseClient();

  final FirebaseAnalytics _firebaseClient = FirebaseAnalytics.instance;

  @override
  Future<void> setUserId(String? userId) async {
    return _firebaseClient.setUserId(id: userId);
  }

  @override
  Future<void> setUserProperty(String propertyId, dynamic value) async {
    return _firebaseClient.setUserProperty(name: propertyId, value: value.toString());
  }

  @override
  Future<void> logEvent(String eventId, Map<String, dynamic> properties) async {
    return _firebaseClient.logEvent(name: eventId, parameters: properties);
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
  Future<void> setUserId(String? id) async {
    if (id != null) {
      user = People(id);
      _mixpanelClient.identify(id);
    }
  }

  @override
  Future<void> setUserProperty(String propertyId, dynamic value) async {
    user?.setOnce(propertyId, value);
  }

  @override
  Future<void> logEvent(String eventId, Map<String, dynamic> properties) async {
    _mixpanelClient.track(eventId, properties: properties);
  }
}
