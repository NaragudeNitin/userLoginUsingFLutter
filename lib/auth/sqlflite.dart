import 'dart:developer';

import 'package:flutter_application_5_login_logout_signup/model/note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'dart:io' as io;
class SqlFlite {
  static Database? _database;
  SqlFlite._();
  static final instance = SqlFlite._();

  Future<Database?> get db async{
    if (_database != null) {
      return _database;
    }
    return  await initializeDatabase();
  }

  Future<Database> initializeDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = p.join(documentDirectory.path, 'notes.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async{
    await db.execute("CREATE TABLE notes (id TEXT PRIMARY KEY, title TEXT NOT NULL, description TEXT, isSynced INTEGER NOT NULL)");
  }

  Future<LocalNoteModel> insertInDatabase(LocalNoteModel localNoteModel)async{
    log("inside insert method");
    var dbClient = await db;
    log("3444444433333444444 ${localNoteModel.id}, \n ${localNoteModel.description},\n  ${localNoteModel.title},\n  ${localNoteModel.createdAt}, \n ${localNoteModel.isArchived}, \n ${localNoteModel.isDeleted}, \n ${localNoteModel.isSynced}");
    final id = await dbClient!.insert('notes', localNoteModel.toMap());
    log("36363663366");
    log(id.toString());
    return localNoteModel;
  }

  Future<List<LocalNoteModel>> getNotesList()async{
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query('notes');
    return queryResult.map((e) => LocalNoteModel.fromMap(e)).toList();
  }

  Future<List<LocalNoteModel>> getAsyncNotesList() async{
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query('notes', where: 'isSynced', whereArgs: [0]);

    return queryResult.map((e) => LocalNoteModel.fromMap(e)).toList();
  }

  Future<int> update(LocalNoteModel localNoteModel) async{
    log('inside update method');
    var dbClient = await db;
    return dbClient!.update('notes', localNoteModel.toMap(), where: 'id = ?', whereArgs: [localNoteModel.id]);
  }


  // Future<void> addNote(String title, String description, DateTime created, String id) async{
  //   // FirebaseNoteService.instance.addNote(title, description, created);
    
  // }

  // Future<void> updateNote(Note note) async{

  // }

  Future<int> delete(String id)async {

    var dbClient = await db;
    return await dbClient!.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  
}
