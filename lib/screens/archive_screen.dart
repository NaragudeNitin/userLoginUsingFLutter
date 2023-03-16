import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/note.dart';

class ArchieveNoteList extends StatefulWidget {
  const ArchieveNoteList({super.key});

  @override
  State<ArchieveNoteList> createState() => _ArchieveNoteListState();
}

class _ArchieveNoteListState extends State<ArchieveNoteList> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("notes");
  DocumentSnapshot? lastDocument;
  bool isMoreData = true;
  List<Note> list = [];
  final ScrollController controller = ScrollController();
  bool isLoadingData = false;

  @override
  void initState() {
    super.initState();
    paginatedData();
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        paginatedData();
      }
    });
  }

  void paginatedData() async {
    if (isMoreData) {
      setState(() {
        isLoadingData = true;
      });
      final ref = this.ref;
      late QuerySnapshot<Map<String, dynamic>>? querySnapshot;
      if (lastDocument == null) {
        list = [];
        querySnapshot =
            (await ref.where('isDeleted',isEqualTo: false).where('isArchive',isEqualTo: true). limit(10).get()) as QuerySnapshot<Map<String, dynamic>>?;
      } else {
        querySnapshot = (await ref.where('isDeleted',isEqualTo: false).where('isArchive',isEqualTo: true)
            .limit(10)
            .startAfterDocument(lastDocument!)
            .get()) as QuerySnapshot<Map<String, dynamic>>?;
      }
      if (querySnapshot!.docs.isNotEmpty) {
        lastDocument = querySnapshot.docs.last;
      }

     final notes = querySnapshot.docs.map((e) => Note.fromMap(e)).toList();
     log(' this is notez lenght${notes.length.toString()}');

     list.addAll(notes);
      //list.addAll(querySnapshot.docs.map((e) => e.data()));
      log(' this is list lenght after add all${list.length.toString()}');
      setState(() {
        isLoadingData = false;
      });
      if (querySnapshot.docs.length < 10) {
        isMoreData = false;
      }
    } else {
      log("No more data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed:() {
              Navigator.pop(context);             
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.blueGrey[300],
                  ),
                   padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 8.0,
                      ),
                    ),
              ), child: null,
            ),
        ],
        title: const Text("Archives"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: controller,
              itemCount: list.length,
              itemBuilder: (context, index) {
                final note = list[index];
                return ListTile(
                  onTap: () {
                  },
                  title: Text(note.title),
                  subtitle: Text(note.description),
                );
              },
            ),
          ),
          isLoadingData
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
