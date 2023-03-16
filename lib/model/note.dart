import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String id;
  final String title;
  final String description;
  final bool? isArchived;
  final DateTime createdAt;
  final bool isDeleted;


  Note( {
    required this.id,
    required this.title,
    required this.description,
    this.isArchived,
    required this.createdAt,
    this.isDeleted = false,
  });

Note copyWith({String? id, String? title, String? description, bool? isArchived, DateTime? createdAt, bool? isDeleted} ) => Note(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        isArchived: isArchived ?? this.isArchived,
        isDeleted: isDeleted ?? this.isDeleted

      );
  static Note fromMap(QueryDocumentSnapshot<Map<String, dynamic>> e) {
    final data = e.data();
    // print("111111111111111111111111111111111");

    final title = data['title'];
    // print("3333333333333333333333333");

    final description = data['description'];
    final id = data['id'];
    final createdAt = data['createdAt'] ;
    final isArchive = data['isArchive'] ;
    final isDeleted = data['isDeleted'] ;

    return Note(
      id: id,
      title: title,
      description: description,
      createdAt: DateTime.now(),
      isArchived: isArchive,
      isDeleted: isDeleted
    );

    // log( '${" is iddddd" + title}dddd dddddddddddd' + description);
  }
}
class LocalNoteModel{
  String id;
  String title;
  String description;
  bool isSynced;
  bool? isArchived;
  bool? isDeleted;
  String? createdAt;

  LocalNoteModel(
    {required this.id, 
    required this.title, 
    required this.description, 
    required this.isSynced, 
    this.isArchived,
    this.isDeleted,
    this.createdAt}
  );

  LocalNoteModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        description = res['description'],
        isSynced = res['isSynced'] == 1 ? true : false,
        isArchived = res['isArchived'],
        isDeleted = res['isDeleted'],
        createdAt = res['createdAt']
        ; 

  Map<String, dynamic> toMap(){
    return{
      'id' : id,
      'title' : title,
      'description' : description,
      'isSynced' : isSynced ? 1 : 0,
      // 'isArchived' : isArchived,
      // 'isDeleted' : isDeleted,
      // 'createdAt' : createdAt
    };
  }

  Note convertToNotesModel(){
    return Note(
      id : id,
      title : title,
      description: description,
      createdAt: DateTime.now()
    );
  }
}
