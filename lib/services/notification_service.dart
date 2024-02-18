import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('lita');
    var iosInitializationSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );
    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {},
    );
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "1",
        "Pengingat Absensi",
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  presensiNotificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "2",
        "Status Presensi",
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<PermissionStatus> getNotificationPermission() async {
    var status = await Permission.notification.status;

    if (status.isDenied) {
      final result = await Permission.notification.request();
      return result;
    } else {
      return status;
    }
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    return flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      await notificationDetails(),
    );
  }

  Future scheduleNotification() async {
    DateTime today = DateTime.now();

    if (today.weekday >= DateTime.monday &&
        today.weekday <= DateTime.saturday) {
      DateTime tomorrowAt0630 = DateTime(
        today.year,
        today.month,
        today.day,
        6,
        30,
      );

      if (today.isAfter(tomorrowAt0630)) {
        tomorrowAt0630 = tomorrowAt0630.add(const Duration(days: 1));

        return flutterLocalNotificationsPlugin.zonedSchedule(
          2,
          "Pengingat Absensi",
          "Hai temen lita, jangan lupa absen hari ini ya!!!",
          tz.TZDateTime.from(
            tomorrowAt0630,
            tz.local,
          ),
          await notificationDetails(),
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        );
      }

      return flutterLocalNotificationsPlugin.zonedSchedule(
        2,
        "Pengingat Absensi",
        "Hai temen lita, jangan lupa absen hari ini ya!!!",
        tz.TZDateTime.from(
          tomorrowAt0630,
          tz.local,
        ),
        await notificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );

      // print("Tanggal dengan waktu pukul 06:30 besok: $tomorrowAt0630");
    } else {
      // Jika hari ini Minggu, Anda dapat menyesuaikan logika sesuai kebutuhan
      // print("Hari ini bukan hari kerja (Senin-Sabtu)");
    }
  }
}
