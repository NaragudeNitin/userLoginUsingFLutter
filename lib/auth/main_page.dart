import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_5_login_logout_signup/auth/auth_page.dart';
import 'package:flutter_application_5_login_logout_signup/pages/home_page.dart';


class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot) {
          // print(snapshot.data!.uid);
          // FirebaseAuth.instance.signOut();
        if (snapshot.hasData) {
          return const HomePage();
        }
        else{
          return const AuthPage();
        }
      },), 
    );
  }
}