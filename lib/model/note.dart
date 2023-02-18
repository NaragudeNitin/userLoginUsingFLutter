
import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String title;
  final String description;
  // final String id;

  Note({required this.title, required this.description, /* required this.i */d});

  static fromMap(QueryDocumentSnapshot<Map<String, dynamic>> e) {
    final data = e as Map<String, dynamic>;
    // print("111111111111111111111111111111111");

    final title = data['title'];
        // print("3333333333333333333333333");

    final description = data['description'];

    // log( '${" is iddddd" + title}dddd dddddddddddd' + description);
  }


  
}