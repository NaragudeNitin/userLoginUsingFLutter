import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_5_login_logout_signup/auth/main_page.dart';
import 'package:flutter_application_5_login_logout_signup/pages/home_page.dart';
  
  // receives message when app is in background solution for on message
  Future<void> backgroundHandler(RemoteMessage message) async{
    print(message.data.toString());
    print(message.notification!.title);
  }

 void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp( const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(context){
    return  MaterialApp(
    debugShowCheckedModeBanner: false,
     theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
    home: const MainPage(),
    routes: {
      'HomePage':(context) => const HomePage(),
    },
  );
  }
}