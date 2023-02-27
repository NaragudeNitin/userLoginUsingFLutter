import 'package:flutter_application_5_login_logout_signup/auth/note_firebase_service.dart';
import 'package:flutter_application_5_login_logout_signup/auth/sqlflite.dart';
import 'package:flutter_application_5_login_logout_signup/model/note.dart';

/// first copy add method of firebase
/// then update method 
/// then delete method
/// archieve method if possible

class Repository {

  Repository._();
  static final instance = Repository._();
  
  Future<void> addNote(String title, String description, DateTime created) async{
    final id = await NoteFirebaseService.instance.addNote(title, description, created);

    SqlFlite.instance.addNote(title, description, created, id);
  }

  Future<void> deleteNote(String id) async {
    NoteFirebaseService.instance.delete(id).then((_) {
      SqlFlite.instance.delete(id);
    });
  }

  Future<void> updateNote(Note note) async {
    NoteFirebaseService.instance.updateNote(note).then((_)  {
      SqlFlite.instance.updateNote(note);
    });
  }
}