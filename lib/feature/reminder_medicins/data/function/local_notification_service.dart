import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static void onTap(NotificationResponse notificationResponse) {}

  static Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/launcher_icon');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  static void showBasicNotification() {
    final NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'id 1',
        "basic notification",
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    flutterLocalNotificationsPlugin.show(
      0,
      "basic notification",
      'body',
      notificationDetails,
      payload: "payload data",
    );
  }

  static void showRepeatedNotification() {
    final NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'id 1',
        "repeated notification",
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      "repeated notification",
      'body',
      RepeatInterval.everyMinute,
      notificationDetails,
      payload: "payload data",
      androidScheduleMode: AndroidScheduleMode.exact,
    );
  }

  static Future<void> showScheduledNotification({
    String? title,
    String? reminder,
    required int year,
    required int month,
    required int day,
    required int hour,
    required int minute,
  }) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));

    final NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'id 1',
        "schedule notification",
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title ?? "Scheduled Notification",
      reminder ?? "It's time!",
      tz.TZDateTime(tz.local, year, month, day, hour, minute),
      notificationDetails,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exact,
    );
  }
}
