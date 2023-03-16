import 'package:flutter_application_5_login_logout_signup/auth/note_firebase_service.dart';
import 'package:flutter_application_5_login_logout_signup/auth/sqlflite.dart';
import 'package:flutter_application_5_login_logout_signup/model/note.dart';
import 'package:flutter_application_5_login_logout_signup/utils/internet_connection.dart';
import 'package:uuid/uuid.dart';

/// first copy add method of firebase
/// then update method 
/// then delete method
/// archieve method 

class Repository {

  Repository._();
  static final instance = Repository._();
  
  Future<void> addNote(String title, String description, DateTime created, bool isArchive) async{

    if (InternetConnection.instance.isDeviceConnected) {
      final id = await NoteFirebaseService.instance.addNote(title, description, created, isArchive);
      final localNoteModel = LocalNoteModel(id: id, title: title, description: description, isSynced: true);
      SqlFlite.instance.insertInDatabase(localNoteModel);
    } else {
      final uuid = await const Uuid().v4();
      final localNoteModel = LocalNoteModel(id:uuid, title:title, description:description, isSynced: false);
      SqlFlite.instance.insertInDatabase(localNoteModel);
    }
  }

  Future<void> deleteNote(String id) async {
    NoteFirebaseService.instance.delete(id).then((_) {
      SqlFlite.instance.delete(id);
    });
  }

  Future<void> updateNote(Note note) async {
    NoteFirebaseService.instance.updateNote(note).then((_)  {
      SqlFlite.instance.update(note as LocalNoteModel);
    });
  }

  Future<void> updateIsArchive(Note note) async{
    await NoteFirebaseService.instance.updateIsArchive(note);
  }
}