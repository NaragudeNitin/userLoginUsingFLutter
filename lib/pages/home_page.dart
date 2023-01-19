import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
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
              // GestureDetector(
              //   onTap: () {},
              //   child: const Icon(Icons.grid_view),
              // ),
              // GestureDetector(
              //   onTap: () {},
              //   child: const Icon(Icons.view_list),
              // )

              
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
          backgroundColor: Colors.lightBlueAccent,
          child: const Icon(Icons.add),
        ),

        //body

        body:
            const ListViewPage(),
        );
  }
}
         /**
          * 
          * debouncing
          * fussy search
          * Wrrap the card with Inkwell......then
          *  in addition refer task_list file 
          *  go through add_task_screen file
          *  create a seperate task data file or just declare taskdata list
          *  create a task screen
          *  session management=> shared preference
          *  do google login
          *  do social login
          *  CURD operation
          *  search bar
          *  show only user related data 
          *  like show the notes for particular user only 
          *  data must no be mixed with the other users data
          *
          */

          