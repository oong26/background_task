import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {
  static const CHANNEL_ID = "111";
  static const CHANNEL_NAME = "Local_Notification_Channel";
  static const CHANNEL_DESC = "This_is_Local_Notification_Channel";

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static const AndroidNotificationDetails androidSettings =
      AndroidNotificationDetails(
    CHANNEL_ID,
    CHANNEL_NAME,
    importance: Importance.high,
    priority: Priority.max,
  );

  static Initializer() async {
    tz.initializeTimeZones();
    var jakarta = tz.getLocation('Asia/Jakarta');
    tz.setLocalLocation(jakarta);
    const androidInitialization = AndroidInitializationSettings('app_icon');
    const initializationSettings =
        InitializationSettings(android: androidInitialization);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onNotificationSelect);
  }

  static Future<void> onNotificationSelect(String? payload) async {
    print(payload);
  }

  static ShowNotification() async {
    const notificationDetails = NotificationDetails(android: androidSettings);

    await flutterLocalNotificationsPlugin.show(
        1, 'Hello', 'Hello world', notificationDetails);
  }

  static ShowOneTimeNotification(tz.TZDateTime scheduledDate) async {
    const notificationDetails = NotificationDetails(android: androidSettings);

    // await flutterLocalNotificationsPlugin.schedule(
    //     1,
    //     "Background Task Notification",
    //     "This is a background task notification",
    //     scheduledDate,
    //     notificationDetails);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        2,
        "Background Task Notification",
        "One minute after application opened",
        scheduledDate,
        const NotificationDetails(
            android: AndroidNotificationDetails(CHANNEL_ID, CHANNEL_NAME,
                channelDescription: CHANNEL_DESC)),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
    // await flutterLocalNotificationsPlugin.zonedSchedule(1, "Background Task Notification", "This is a background task notification", scheduledDate, notificationDetails, uiLocalNotificationDateInterpretation: uiLocalNotificationDateInterpretation, androidAllowWhileIdle: true);
  }
}
