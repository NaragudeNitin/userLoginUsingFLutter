import 'package:flutter/material.dart';
import '../readdata/notification_services.dart';

class SetNotification extends StatefulWidget {
  const SetNotification({super.key, required this.title});

  final String title;

  @override
  State<SetNotification> createState() => _SetNotificationState();
}

class _SetNotificationState extends State<SetNotification> {
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    super.initState();
    notificationServices.initialiseNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 165, 176, 197),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                debugPrint("send notification pressed");
                notificationServices.sendNotification(
                    "title", " this is a body");
              },
              child: const Text(
                "Send Notification",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                notificationServices.scheduleNotification(
                    "Scheduled notification", "body of Scheduled notification");
              },
              child: const Text(
                "Schedule Notification",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                notificationServices.stopNotifications();
              },
              child: const Text(
                "Stop Notification",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                notificationServices.stopAllNotifications();
              },
              child: const Text(
                "Stop All Notifications",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
