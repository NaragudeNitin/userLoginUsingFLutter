import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_5_login_logout_signup/model/note.dart';

class NoteFirebaseService {
  NoteFirebaseService._();
  static final instance = NoteFirebaseService._();

  Future<String> addNote(String title, String description, DateTime created) async{
    final document = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("notes").doc();

    var data = {
      'title': title,
      'description': description,
      'createdAt': created,
      'id': document.id
    };

   await document.set(data);
   return document.id;
  }

   Future<void> updateNote(Note note) async{
        var data = {
      'title': note.title,
      'description': note.description,
      'createdAt': note.createdAt,
      'id': note.id
    };

    final document = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("notes").doc(note.id);

     await document.set(data);
   }

  Future<void> delete(String id) async{
    final reference = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("notes");

        await reference.doc(id).delete();
  }
}