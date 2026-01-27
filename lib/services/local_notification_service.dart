import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    const InitializationSettings initializationSettingsAndroid =
        InitializationSettings(
          android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        );

    _notificationsPlugin.initialize(
      settings: initializationSettingsAndroid,

      onDidReceiveNotificationResponse: (details) {
        if (details.input != null) {}
      },
    );
  }

  static Future<void> display(String title, String? message) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails("e", "Main"),
    );

    await _notificationsPlugin.show(
      id: id,
      title: title,
      body: message,
      notificationDetails: notificationDetails
    );
  }
}
