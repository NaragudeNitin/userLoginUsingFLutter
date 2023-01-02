import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetNoteData extends StatelessWidget {
  final String noteId;

  const GetNoteData({super.key, required this.noteId});

  @override
  Widget build(BuildContext context) {
    //get the collection
    CollectionReference tasks = FirebaseFirestore.instance.collection("tasks");

    return FutureBuilder<DocumentSnapshot>(
      future: tasks.doc(noteId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(" ${data['title']}" " " "${data['description']},");
        }

        return const Text("loading...");
      },
    );
  }
}
