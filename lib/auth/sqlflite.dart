import 'package:flutter_application_5_login_logout_signup/model/note.dart';

class SqlFlite {

  SqlFlite._();
  static final instance = SqlFlite._();

  Future<void> addNote(String title, String description, DateTime created, String id) async{
    // FirebaseNoteService.instance.addNote(title, description, created);
    
  }

  Future<void> updateNote(Note note) async{

  }

  Future<void> delete(String id)async {}
}
