import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    // Android initialization
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // ios initialization
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification() async {
    await flutterLocalNotificationsPlugin.show(
      0,
      'This is Title',
      'This is a test body for this notification',
      const NotificationDetails(
        // Android
        android: AndroidNotificationDetails(
          'test_id',
          'test name',
          sound: RawResourceAndroidNotificationSound('medicine_notification'),
          importance: Importance.max,
          enableVibration: true,
          priority: Priority.max,
          color: ColorConstants.lightGrey,
          icon: '@raw/schedule',
          largeIcon: DrawableResourceAndroidBitmap('@raw/schedule'),
        ),
        // iOS
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  Future<void> scheduleNotification(
      {required int id,
      required String title,
      required String body,
      required String channelName,
      required String channelId,
      required String iconPath,
      required String largeIconPath,
      required DateTime dateTime}) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));

    tz.TZDateTime tzDateTime = tz.TZDateTime.from(dateTime, tz.local);

    await AndroidFlutterLocalNotificationsPlugin()
        .requestExactAlarmsPermission();
    // return;
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tzDateTime,
        NotificationDetails(
          // Android
          android: AndroidNotificationDetails(
            channelId,
            channelName,
            sound: const RawResourceAndroidNotificationSound(
                'medicine_notification'),
            importance: Importance.max,
            enableVibration: true,
            priority: Priority.max,
            color: ColorConstants.lightGrey,
            icon: iconPath,
            largeIcon: DrawableResourceAndroidBitmap(largeIconPath),
          ),
          // iOS
          iOS: const DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.alarmClock,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
