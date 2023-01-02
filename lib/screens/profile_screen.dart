import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
  double screenHeight = 0;
  double scrrenWidth = 0;
  Color primary = const Color(0x00000001);
  String profilePicLink = " ";

  void pickUploadImage() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
        imageQuality: 75);

    
    Reference ref = FirebaseStorage.instance.ref().child("profilepic.jpg");

    await ref.putFile(File(image!.path));

    ref.getDownloadURL().then((value) async {
      setState(() {
        profilePicLink = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          pickUploadImage();
        },
        child: Container(
          margin: const EdgeInsets.only(top: 80, bottom: 24),
          height: 120,
          width: 120,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: primary,
          ),
          child: Flexible(
            child: Column( 
              children: [
                Center(
                  child: profilePicLink == " " //if image url is empty then show person icon
                      ? const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 80,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(profilePicLink),
                        ),
                ),
                const Text("upload from gallary",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),)
              ],
            ),
          ),
          
        ),
      ),
    );
  }
}
