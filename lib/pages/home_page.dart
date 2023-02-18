// ignore_for_file: avoid_print

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_cloud_messaging_flutter/firebase_cloud_messaging_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_5_login_logout_signup/screens/add_note_screen.dart';
import 'package:flutter_application_5_login_logout_signup/screens/pagination_screen.dart';
import 'package:flutter_application_5_login_logout_signup/screens/search_screen.dart';
import 'package:flutter_application_5_login_logout_signup/widgets/side_bar_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    // getTas
    super.initState();

    //gives you the message on which yousr taps
    //and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message){
      if (message != null) {
        final routeFromMessage = message.data['route'];
        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    //only works in foreground
    FirebaseMessaging.onMessage.listen((message) {
      if(message.notification != null){
        print(message.notification!.title);
        print(message.notification!.body);
      }
      ///app in background and opened and user taps on notification
      /// on the notification
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        final routeFromMessage = message.data['route'];
        // print(routeFromMessage);

        Navigator.of(context).pushNamed(routeFromMessage);
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ));
                },
                child: const Icon(Icons.search)),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
      drawer: const SideMenuBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTaskScreen(),
            ),
          ).then((value) {
            stdout.writeln("calling setstate");
            setState(() {});
          });
        },
        backgroundColor: const Color.fromARGB(255, 55, 72, 80),
        child: const Icon(Icons.add),
      ),

      //body

      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Theme.of(context).canvasColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: const PaginatedList(),
        ),
      ),
    );
  }
}
