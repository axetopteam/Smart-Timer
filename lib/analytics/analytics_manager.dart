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

  static AnalyticsEvent get eventAppOpened => AnalyticsEvent('app_opened');
  static AnalyticsEvent get eventAppClosed => AnalyticsEvent('app_closed');
  static AnalyticsEvent get eventFirstLaunch => AnalyticsEvent('first_launch');

  //покупка
  static AnalyticsEvent get eventSubscriptionTrialActivated => AnalyticsEvent('subscription_trial_activated_client');
  static AnalyticsEvent get eventSubscriptionPurchaseDone => AnalyticsEvent('subscription_purchase_done_client');
  static AnalyticsEvent get eventSubscriptionPurchaseFailed => AnalyticsEvent('subscription_purchase_failed_client');

  //настройки
  static AnalyticsEvent get eventSettingsOpened => AnalyticsEvent('settings_opened');
  static AnalyticsEvent get eventSettingsBiometryToggled => AnalyticsEvent('settings_biometry_toggled');
  static AnalyticsEvent get eventSettingsPinPressed => AnalyticsEvent('settings_pin_pressed');
  static AnalyticsEvent get eventSendLogsPressed => AnalyticsEvent('send_logs_pressed');
  static AnalyticsEvent get eventSettingsLogoutPressed => AnalyticsEvent('settings_logout_pressed');
  static AnalyticsEvent get eventSettingsDeletePressed => AnalyticsEvent('settings_delete_pressed');
  static AnalyticsEvent get eventProfileSuccessfullyRemoved => AnalyticsEvent('profile_successfully_removed');

  // уведомления
  static AnalyticsEvent get eventNotificationsOpened => AnalyticsEvent('notifications_opened');
  static AnalyticsEvent get eventNotificationsSearchActivated => AnalyticsEvent('notifications_search_activated');
  static AnalyticsEvent get eventNotificationsAppointmentPressed => AnalyticsEvent('notifications_appointment_pressed');

  //запись
  static AnalyticsEvent get eventAppointmentsOpened => AnalyticsEvent('appointments_opened');
  static AnalyticsEvent get eventAppointmentsOpenedMainScreen => AnalyticsEvent('appointments_opened_main_screen');
  static AnalyticsEvent get eventAppointmentsSpecialitySearch => AnalyticsEvent('appointments_speciality_search');
  static AnalyticsEvent get eventAppointmentPredefineSelection => AnalyticsEvent('appointment_predefine_selection');
  static AnalyticsEvent get eventAppointmentsSpecialitySelected => AnalyticsEvent('appointments_speciality_selected');
  static AnalyticsEvent get eventAppointmentUserSelection => AnalyticsEvent('appointment_user_selection');
  static AnalyticsEvent get eventAppointmentsDoctorSelected => AnalyticsEvent('appointments_doctor_selected');
  static AnalyticsEvent get eventAppointmentsSelectionOpened => AnalyticsEvent('appointments_selection_opened');
  static AnalyticsEvent get eventAppointmentsFilterAllOpened => AnalyticsEvent('appointments_filter_all_opened');
  static AnalyticsEvent get eventAppointmentsFilterTimeOpened => AnalyticsEvent('appointments_filter_time_opened');
  static AnalyticsEvent get eventAppointmentsFilterDateOpened => AnalyticsEvent('appointments_filter_date_opened');
  static AnalyticsEvent get eventAppointmentsFilterClinicOpened => AnalyticsEvent('appointments_filter_clinic_opened');
  static AnalyticsEvent get eventAppointmentsFilterServiceOpened =>
      AnalyticsEvent('appointments_filter_service_opened');
  static AnalyticsEvent get eventAppointmentsSpecialistInfo => AnalyticsEvent('appointments_specialist_info');
  static AnalyticsEvent get eventAppointmentPriceInfo => AnalyticsEvent('appointment_price_info');
  static AnalyticsEvent get eventAppointmentScrollTimeslots => AnalyticsEvent('appointment_scroll_timeslots');
  static AnalyticsEvent get eventAppointmentsSpecialistSelected => AnalyticsEvent('appointments_specialist_selected');
  static AnalyticsEvent get eventAppointmentsConfirmOpened => AnalyticsEvent('appointments_confirm_opened');
  static AnalyticsEvent get eventAppointmentsConfirmSuccessPressed =>
      AnalyticsEvent('appointments_confirm_success_pressed');

  //главный экран
  static AnalyticsEvent get eventMainScreenOpened => AnalyticsEvent('main_screen_opened');
  static AnalyticsEvent get eventNoSubscribtionScreenOpened => AnalyticsEvent('no_subscribtion_screen_opened');
  static AnalyticsEvent get eventSelectDoctorWebsitePressed => AnalyticsEvent('select_doctor_website_pressed');

  //мед. карта
  static AnalyticsEvent get eventMedcardOpened => AnalyticsEvent('medcard_opened');
  static AnalyticsEvent get eventMedcardOpenedMainScreen => AnalyticsEvent('medcard_opened_main_screen');

  //другое
  static AnalyticsEvent get eventMenuOpened => AnalyticsEvent('menu_opened');

  //клиники
  static AnalyticsEvent get eventClinicsOpened => AnalyticsEvent('clinicks_opened');

  //оплата услуг
  static AnalyticsEvent get eventBalanceOpened => AnalyticsEvent('balance_opened');

  //подписки
  static AnalyticsEvent get eventSubscriptionsOpened => AnalyticsEvent('subscriptions_opened');

  //дежурный доктор
  static AnalyticsEvent get eventDutyDoctorConfigLoaded => AnalyticsEvent('duty_doctor_config_loaded');
  static AnalyticsEvent get eventDutyDoctorButtonPressed => AnalyticsEvent('duty_doctor_button_pressed');

  //умный поиск
  static AnalyticsEvent get eventSearchNotFound => AnalyticsEvent('search_not_found');
  static AnalyticsEvent get eventSearchSuccessful => AnalyticsEvent('search_successful');
}

enum MedcardOpenedFrom {
  tabBar,
  mainScreen,
} //for analytics

enum AppointmentSearchOpenedFrom {
  tabBar,
  mainScreen,
  notifications,
  smartSearch,
} //for analytics

enum AppointmentFilterOpenedFrom {
  search,
  reservation,
  referralPreview,
  referralPage,
  doctorSubscription,
} //for analytics
