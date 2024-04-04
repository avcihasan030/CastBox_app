import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future initialize() async {
    const androidInitialize =
        AndroidInitializationSettings('mipmap/ic_launcher');
    const initializationSettings =
        InitializationSettings(android: androidInitialize);
    await _notifications.initialize(initializationSettings);
  }

  static Future notificationDetails() async => const NotificationDetails(
        android: AndroidNotificationDetails('castbox_id', 'CastBox',
            importance: Importance.max),
      );

  static Future showNotification(
          {int id = 0,
          required String title,
          required String body,
          required String payload}) async =>
      _notifications.show(id, title, body, await notificationDetails(),
          payload: payload);

  static Future scheduleNotification({
    int id = 0,
    required String? title,
    required String? body,
    required String? payload,
    required DateTime scheduledDate,
  }) async =>
      _notifications.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(scheduledDate, tz.local),
          await notificationDetails(),
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidScheduleMode: AndroidScheduleMode.alarmClock);

  static Future unscheduleAllNotifications() async =>
      await _notifications.cancelAll();
}
