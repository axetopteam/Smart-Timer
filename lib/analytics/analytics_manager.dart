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

  //amrap
  static AnalyticsEvent get eventAmrapOpened => AnalyticsEvent('amrap_opened');
  static AnalyticsEvent get eventAmrapClosed => AnalyticsEvent('amrap_closed');
  static AnalyticsEvent get eventAmrapTimerStarted => AnalyticsEvent('amrap_timer_started');
  static AnalyticsEvent get eventAmrapNewAdded => AnalyticsEvent('amrap_new_added');
  static AnalyticsEvent get eventAmrapRemoved => AnalyticsEvent('amrap_removed');

  //Afap
  static AnalyticsEvent get eventAfapOpened => AnalyticsEvent('afap_opened');
  static AnalyticsEvent get eventAfapClosed => AnalyticsEvent('afap_closed');
  static AnalyticsEvent get eventAfapTimerStarted => AnalyticsEvent('afap_timer_started');
  static AnalyticsEvent get eventAfapNewAdded => AnalyticsEvent('afap_new_added');
  static AnalyticsEvent get eventAfapRemoved => AnalyticsEvent('afap_removed');

  //Emom
  static AnalyticsEvent get eventEmomOpened => AnalyticsEvent('emom_opened');
  static AnalyticsEvent get eventEmomClosed => AnalyticsEvent('emom_closed');
  static AnalyticsEvent get eventEmomTimerStarted => AnalyticsEvent('emom_timer_started');
  static AnalyticsEvent get eventEmomNewAdded => AnalyticsEvent('emom_new_added');
  static AnalyticsEvent get eventEmomRemoved => AnalyticsEvent('emom_removed');

  //Tabata
  static AnalyticsEvent get eventTabataOpened => AnalyticsEvent('tabata_opened');
  static AnalyticsEvent get eventTabataClosed => AnalyticsEvent('tabata_closed');
  static AnalyticsEvent get eventTabataTimerStarted => AnalyticsEvent('tabata_timer_started');
  static AnalyticsEvent get eventTabataNewAdded => AnalyticsEvent('tabata_new_added');
  static AnalyticsEvent get eventTabataRemoved => AnalyticsEvent('tabata_removed');

  //WorkRest
  static AnalyticsEvent get eventWorkRestOpened => AnalyticsEvent('work_rest_opened');
  static AnalyticsEvent get eventWorkRestClosed => AnalyticsEvent('work_rest_closed');
  static AnalyticsEvent get eventWorkRestTimerStarted => AnalyticsEvent('work_rest_timer_started');

  //timer
  static AnalyticsEvent get eventTimerOpened => AnalyticsEvent('timer_opened');
  static AnalyticsEvent get eventTimerStarted => AnalyticsEvent('timer_started');
  static AnalyticsEvent get eventTimerPaused => AnalyticsEvent('timer_paused');
  static AnalyticsEvent get eventTimerResumed => AnalyticsEvent('timer_resumed');
  static AnalyticsEvent get eventTimerFinished => AnalyticsEvent('timer_finished');
  static AnalyticsEvent get eventTimerRoundCompleted => AnalyticsEvent('timer_round_completed');
  static AnalyticsEvent get eventTimerSoundSwitched => AnalyticsEvent('timer_sound_switched');
  static AnalyticsEvent get eventTimerClosed => AnalyticsEvent('timer_closed');

  //settings
  static AnalyticsEvent get eventSettingsOpened => AnalyticsEvent('settings_opened');
  static AnalyticsEvent get eventSettingsClosed => AnalyticsEvent('settings_closed');
  static AnalyticsEvent get eventSettingsPurchasePressed => AnalyticsEvent('settings_purchase_pressed');
  static AnalyticsEvent get eventSettingsSoundSwitched => AnalyticsEvent('settings_sound_switched');
  static AnalyticsEvent get eventSettingsRateUsPressed => AnalyticsEvent('settings_rate_us_pressed');
  static AnalyticsEvent get eventSettingsContactUsPressed => AnalyticsEvent('settings_contact_us_pressed');

  //purchase
  static AnalyticsEvent get eventPaywallOpened => AnalyticsEvent('paywall_opened');
  static AnalyticsEvent get eventPaywallShowed => AnalyticsEvent('paywall_showed');
  static AnalyticsEvent get eventPaywallClosed => AnalyticsEvent('paywall_closed');
  static AnalyticsEvent get eventSubscriptionTrialActivated => AnalyticsEvent('subscription_trial_activated_client');
  static AnalyticsEvent get eventSubscriptionPurchaseDone => AnalyticsEvent('subscription_purchase_done_client');
  static AnalyticsEvent get eventSubscriptionPurchaseFailed => AnalyticsEvent('subscription_purchase_failed_client');
}
