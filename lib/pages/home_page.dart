import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_5_login_logout_signup/screens/add_note_screen.dart';
import 'package:flutter_application_5_login_logout_signup/screens/search_screen.dart';
import 'package:flutter_application_5_login_logout_signup/views/list_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    // getTaskDetails();
    super.initState();
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
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  Text(
                    user.email!,
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: const [
                  Text(
                    'Logout',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  Icon(Icons.logout)
                ],
              ),
              // iconColor: Colors.redAccent,
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
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
        backgroundColor:const Color.fromARGB(255, 55, 72, 80),
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
          child: const ListViewPage(),
        ),
      ),
    );
  }
}

          