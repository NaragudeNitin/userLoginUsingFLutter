
import 'package:flutter_application_5_login_logout_signup/pages/login_page.dart';
import 'package:flutter_application_5_login_logout_signup/pages/register_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //initially show login page
  bool showLoginPage = true;

  void toggleScreens(){
    setState(() {
      showLoginPage = !showLoginPage; //this line checks user is logged in or not
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
    return LoginPage(showRegisterPage: toggleScreens,);
    }else{
      return RegisterPage(showLoginPage: toggleScreens,);
    }
  }
}