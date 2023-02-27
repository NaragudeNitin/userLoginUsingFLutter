import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  
  static Future<void> signIn( String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password);
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(),));
    } on FirebaseAuthException {
      throw IncorrectPasswordAndEmailException();
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return const AlertDialog(
      //         content: Text("incorrect password or email address!!"),
      //       );
      //     });
    }
  }
}

class IncorrectPasswordAndEmailException implements Exception{
  
}