import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../model/note.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
    final user = FirebaseAuth.instance.currentUser!;

  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("tasks");

      List<Map<String, dynamic>> list = [];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length, 
      itemBuilder: ( context, index) {
        ref.get();
         Note note = list[index] as Note;
        if(note.isArchived == false){
          return const SizedBox.shrink();
        }
        return ListTile(
          title: Text(note.title),
          subtitle: Text(note.description), 
        );
        },
    );
  }
}