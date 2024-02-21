import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> showNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'report_alert',
    'Report Alert',
    channelDescription: 'Alert about generate reports',
    importance: Importance.max,
    priority: Priority.high,
    icon: '@mipmap/ic_launcher',
    showWhen: false,
  );

  const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(0, message.data['title'], message.data['body'], platformChannelSpecifics,
      payload: 'item x');
}
