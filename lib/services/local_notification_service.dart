
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService{
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = 
    FlutterLocalNotificationsPlugin();

  static void initialize(){
    const InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings("logo")
    );
    _notificationsPlugin.initialize(initializationSettings);
  }

  static void display(RemoteMessage message)async{

    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/1000;
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        "easyapproach", 
        "easyapproach_channel",
        channelDescription: "this is the My first channel created for Local Notification",
        importance: Importance.max,
        playSound: true,
        priority: Priority.high
         ),
    );

   await  _notificationsPlugin.show(
      id, 
      message.notification!.title, 
      message.notification!.body, 
      notificationDetails,
      payload: message.data['route']
    );
    } catch (e) {
      print(e);
    }
    
  }
}