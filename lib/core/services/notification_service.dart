import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final _messaging = FirebaseMessaging.instance;
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    NotificationSettings settings = await _messaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("Notification permission granted");

      final apnsToken = await _messaging.getAPNSToken();
      print("APNs token: $apnsToken");

      final fcmToken = await _messaging.getToken();
      print("FCM token: $fcmToken");

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        final notification = message.notification;
        if (notification != null) {
          _showNotification(notification.title, notification.body);
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print("🔔 Notification tapped: ${message.data}");
      });

      const android = AndroidInitializationSettings('@mipmap/ic_launcher');
      const settingsInit = InitializationSettings(android: android);
      await _flutterLocalNotificationsPlugin.initialize(settingsInit);
    } else {
      print("Notification permission denied");
    }

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings iosSettings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (iosSettings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Notification permission granted.');
    } else {
      print('Notification permission denied.');
    }
  }

  Future<void> _showNotification(String? title, String? body) async {
    const android = AndroidNotificationDetails(
      'news_channel',
      'News Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const platform = NotificationDetails(android: android);
    await _flutterLocalNotificationsPlugin.show(0, title, body, platform);
  }
}
