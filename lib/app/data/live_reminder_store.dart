import 'package:flutter/foundation.dart';

class LiveReminderStore {
  LiveReminderStore._();

  static final ValueNotifier<Set<String>> reminders = ValueNotifier(<String>{});

  static bool isReserved(String reminderId) => reminders.value.contains(reminderId);

  static void reserve(String reminderId) {
    if (isReserved(reminderId)) {
      return;
    }
    reminders.value = {...reminders.value, reminderId};
  }
}

String buildLiveReminderId({
  required String sellerUsername,
  required String liveTitle,
  required String schedule,
}) {
  return '$sellerUsername|$liveTitle|$schedule';
}
