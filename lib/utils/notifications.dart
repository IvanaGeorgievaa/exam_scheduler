import '../model/exam.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as timezone;

class NotificationApi {
  static const String notificationTitle = 'Exam Reminder';
  static const String notificationPayload = 'exam.reminder';
  static final _notifications = FlutterLocalNotificationsPlugin();
  static int notificationCounter = 0;

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        channelDescription: 'channel_description',
        importance: Importance.high,
        playSound: true,
        ongoing: true,
        styleInformation: BigTextStyleInformation(""),
        icon: "ic_notification",
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  static init() {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: ios);

    _notifications.initialize(settings);
    tz.initializeTimeZones();
  }

  static Future _showNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payload,
      required DateTime dateTime}) async {
    if (DateTime.now().isBefore(dateTime) ||
        DateTime.now().isAtSameMomentAs(dateTime)) {
      _notifications.zonedSchedule(
        id,
        title,
        body,
        timezone.TZDateTime.from(dateTime, timezone.local),
        await _notificationDetails(),
        payload: payload,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true,
      );
    }
  }

  static scheduleNotification(Exam exam) {
    String notificationTitle = "Upcoming Exam";
    String notificationPayload = "exam.reminder";

    _showNotification(
      id: notificationCounter++,
      title: notificationTitle,
      payload: notificationPayload,
      body: "An exam by the name of ${exam.subjectName} is starting in 1 hour.",
      dateTime: exam.getDateAndTime.subtract(const Duration(hours: 1)),
    );

    _showNotification(
      id: notificationCounter++,
      title: notificationTitle,
      payload: notificationPayload,
      body:
          "An exam by the name of ${exam.subjectName} is starting in 30 minutes.",
      dateTime: exam.getDateAndTime.subtract(const Duration(minutes: 30)),
    );

    _showNotification(
      id: notificationCounter++,
      title: notificationTitle,
      payload: notificationPayload,
      body: "An exam by the name of ${exam.subjectName} is starting now!",
      dateTime: exam.getDateAndTime,
    );
  }

  static scheduleNotifications(List<Exam> exams) {
    for (var exam in exams) {
      scheduleNotification(exam);
    }
  }

  static Future showLocationNotification(
      String subjectName, String distance) async {
    String notificationBody =
        'You are $distance close to the location of the exam for subject $subjectName';

    _notifications.show(
      notificationCounter++,
      notificationTitle,
      notificationBody,
      await _notificationDetails(),
      payload: notificationPayload,
    );
  }

  static void cancelNotifications() => _notifications.cancelAll();
}
