import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_5_login_logout_signup/model/note.dart';

class NoteFirebaseService {
  NoteFirebaseService._();
  static final instance = NoteFirebaseService._();

  static var ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("notes");

  Future<String> addNote(String title, String description, DateTime created, bool isArchive) async{
    final document = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("notes").doc();

    var data = {
      'title': title,
      'description': description,
      'createdAt': created,
      'id': document.id,
      'isArchive': isArchive,
      'isDeleted' : false
    };

   await document.set(data);
   return document.id;
  }

   Future<void> updateNote(Note note) async{
        var data = {
      'title': note.title,
      'description': note.description,
      'createdAt': note.createdAt,
      'id': note.id,
      'isArchive': note.isArchived,
      'isDeleted' : note.isDeleted
      
    };

    final document = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("notes").doc(note.id);

     await document.set(data);
   }

  Future<void> delete(String id) async{
    final document = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("notes").doc(id);

     await document.update({'isDeleted' : true});
  }

 Future<void> updateIsArchive(Note note)  async{
    final isArchive = note.isArchived ?? false;
      var data = {
      'title': note.title,
      'description': note.description,
      'createdAt': note.createdAt,
      'id': note.id,
      'isArchive': !isArchive,
      'isDeleted' : note.isDeleted
    };

    final document = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("notes").doc(note.id);

     await document.set(data);
  }

  // static updateFirestoreWithLocalDb(convertToNotesModel) {}

  static Future<void> updateFirestoreWithLocalDb(Note notes) async {
    DocumentReference document = ref.doc(notes.id);
    await document.set({
      'id': notes.id,
      'title': notes.title,
      'description': notes.description,
      'date': DateTime.now()
    });
  }
}