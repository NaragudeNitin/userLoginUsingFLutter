import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_5_login_logout_signup/views/web_view_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../pages/home_page.dart';

class SideMenuBar extends StatefulWidget {
  const SideMenuBar({super.key});

  @override
  State<SideMenuBar> createState() => _SideMenuBarState();
}

class _SideMenuBarState extends State<SideMenuBar> {

  final user = FirebaseAuth.instance.currentUser;
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  String? profilePicLink;


  Future pickUploadProfilePic() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );

    Reference ref = FirebaseStorage.instance.ref().child("profilepic.jpg");
    if(image == null )return ;
    await ref.putFile(File(image.path));

    ref.getDownloadURL().then((value) async {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('images')
          .add({'imageUrl': value});
      setState(() {
        profilePicLink = value;
      });
    });
  }

  Future<void> fetchProfileImage() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('images')
        .get()
        .then((snapshot) {

      if(snapshot.docs.first.exists){
        final imageUrl = snapshot.docs.first.data()['imageUrl'];
        setState(() {
          profilePicLink = imageUrl;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProfileImage();
  }

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser!;
    return Drawer(
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
                GestureDetector(
                  onTap: () {
                    setState(() {
                      pickUploadProfilePic();
                    });
                  },
                  child: CircleAvatar(
                    radius: 50,
                    child: profilePicLink == null
                        ? const Icon(
                            Icons.person,
                            size: 80,
                          )
                        : CircleAvatar(
                            radius: 40,
                            child: Image.network(
                              profilePicLink!,
                              fit: BoxFit.contain,
                            ),
                          ),
                  ),
                ),
                Text(
                  user!.email!,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),

          //Notes
          ListTile(
            leading: const Icon(Icons.message),
            title: const Text(
              'My Notes',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ),

          //archives
          ListTile(
            leading: const Icon(Icons.archive),
            title: const Text(
              'Archive',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {},
          ),

          //reminder
          ListTile(
              leading: const Icon(Icons.remember_me),
              title: const Text(
                'Add Remainder',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {}),

          //terms and condition/ webview
          ListTile(
            leading: const Icon(Icons.web),
            title: const Text(
              'Terms and Conditions',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebView(),
                  ));
            },
          ),

          //signout
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              'Sign Out',
              style: TextStyle(fontSize: 20, color: Colors.redAccent),
            ),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
