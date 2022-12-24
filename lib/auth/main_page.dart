import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_5_login_logout_signup/auth/auth_page.dart';
import 'package:flutter_application_5_login_logout_signup/pages/home_page.dart';
import 'package:flutter_application_5_login_logout_signup/pages/login_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        }
        else{
          return AuthPage();
        }
      },), 
    );
  }
}