import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings(('logo'));

  void initialiseNotification() async {
    InitializationSettings initializationSettings = 
    InitializationSettings(android: _androidInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void sendNotification(String title, String body) async{

    AndroidNotificationDetails androidNotificationDetails = 
    const AndroidNotificationDetails(
      "channelId", 
      "channelName",
      playSound: true,
      importance: Importance.high,
      priority: Priority.high);

    NotificationDetails notificationDetails = 
    NotificationDetails(android: androidNotificationDetails);

    await _flutterLocalNotificationsPlugin.show(
      0, 
      title, 
      body, 
      notificationDetails
      );
  }

  void scheduleNotification(String title, String body) async{

    AndroidNotificationDetails androidNotificationDetails = 
    const AndroidNotificationDetails(
      "channelId", 
      "channelName",
      playSound: true,
      importance: Importance.high,
      priority: Priority.high);

    NotificationDetails notificationDetails = 
    NotificationDetails(android: androidNotificationDetails);

    await _flutterLocalNotificationsPlugin.periodicallyShow(
      0, 
      title, 
      body, 
      RepeatInterval.everyMinute, 
      notificationDetails);
  }

  void stopNotifications () async {
    _flutterLocalNotificationsPlugin.cancel(0);
  }

  void stopAllNotifications () async {
    _flutterLocalNotificationsPlugin.cancelAll();
  }
}
