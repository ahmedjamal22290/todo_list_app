import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _isInialized = false;
  bool get isInialized => _isInialized;
  Future<void> initNotification() async {
    if (_isInialized) return;
    const initAndroidSetting =
        AndroidInitializationSettings('@mipmap-hdpi/ic_launcher.png');
    const initIosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings = InitializationSettings(
      android: initAndroidSetting,
      iOS: initIosSettings,
    );
    await notificationsPlugin.initialize(initSettings);
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'Daily channel Id',
          'Daily noti',
          channelDescription: 'daily noti descrip',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails());
  }

  Future<void> showNotificatino(
      {int id = 0, String? title, String? body}) async {
    return notificationsPlugin.show(
        id, title, body, const NotificationDetails());
  }
}
