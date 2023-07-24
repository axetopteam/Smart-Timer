import 'package:flutter/foundation.dart';

import 'analytics_client.dart';

class AnalyticsEvent {
  final String eventId;
  final Map<String, Object> _properties = <String, Object>{};

  AnalyticsEvent(this.eventId);

  AnalyticsEvent setProperty(String propertyName, Object? propertyValue) {
    if (propertyValue == null) {
      _properties.remove(propertyName);
    } else {
      _properties[propertyName] = propertyValue;
    }
    return this;
  }

  void commit() {
    AnalyticsManager().logEvent(eventId, _properties);
  }
}

class AnalyticsManager {
  static final AnalyticsManager _instance = AnalyticsManager._internal();

  factory AnalyticsManager() {
    return _instance;
  }

  AnalyticsManager._internal();

  List<AnalyticsClient> _analyticsClients = [];

  String? _userId;
  String? get userId => _userId;

  Future<bool> initialize() async {
    if (kDebugMode) {
      _analyticsClients = <AnalyticsClient>[
        DebugAnalyticsClient(),
        FirebaseClient(),
        MixPanelClient('8951af7c079dc73f12a885cb20370c99'),
      ];
    } else {
      _analyticsClients = <AnalyticsClient>[
        FirebaseClient(),
        MixPanelClient('8951af7c079dc73f12a885cb20370c99'),
      ];
    }

    for (var i = 0; i < _analyticsClients.length; ++i) {
      await _analyticsClients[i].initialize();
    }
    return true;
  }

  Future<void> setUserId(String? userId) async {
    _userId = userId;
    for (var client in _analyticsClients) {
      await client.setUserId(userId);
    }
  }

  void setUserProperty(String propertyId, dynamic value) {
    for (var client in _analyticsClients) {
      client.setUserProperty(propertyId, value);
    }
  }

  void logEvent(String eventId, Map<String, Object> properties) {
    for (var client in _analyticsClients) {
      client.logEvent(eventId, properties);
    }
  }

  //app
  static AnalyticsEvent get eventAppOpened => AnalyticsEvent('app_opened');
  static AnalyticsEvent get eventAppClosed => AnalyticsEvent('app_closed');
  static AnalyticsEvent get eventFirstLaunch => AnalyticsEvent('first_launch');

  //settings
  static AnalyticsEvent get eventSettingsOpened => AnalyticsEvent('settings_opened');
  static AnalyticsEvent get eventSettingsClosed => AnalyticsEvent('settings_closed');

  //purchase
  static AnalyticsEvent get eventPaywallOpened => AnalyticsEvent('paywall_opened');
  static AnalyticsEvent get eventPaywallShowed => AnalyticsEvent('paywall_showed');
  static AnalyticsEvent get eventPaywallClosed => AnalyticsEvent('paywall_closed');
  static AnalyticsEvent get eventSubscriptionTrialActivated => AnalyticsEvent('subscription_trial_activated_client');
  static AnalyticsEvent get eventSubscriptionPurchaseDone => AnalyticsEvent('subscription_purchase_done_client');
  static AnalyticsEvent get eventSubscriptionPurchaseFailed => AnalyticsEvent('subscription_purchase_failed_client');
}
