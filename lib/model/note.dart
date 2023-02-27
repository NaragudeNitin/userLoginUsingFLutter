import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String id;
  final String title;
  final String description;
  final bool? isArchived;
  final DateTime createdAt;

  Note({
    required this.id,
    required this.title,
    required this.description,
    this.isArchived,
    required this.createdAt,
  });

Note copyWith({String? id, String? title, String? description, bool? isArchived, DateTime? createdAt} ) => Note(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        isArchived: isArchived ?? this.isArchived

      );
  static Note fromMap(QueryDocumentSnapshot<Map<String, dynamic>> e) {
    final data = e.data();
    // print("111111111111111111111111111111111");

    final title = data['title'];
    // print("3333333333333333333333333");

    final description = data['description'];
    final id = data['id'];
    final createdAt = data['createdAt'] ;

    return Note(
      id: id,
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );

    // log( '${" is iddddd" + title}dddd dddddddddddd' + description);
  }
}
