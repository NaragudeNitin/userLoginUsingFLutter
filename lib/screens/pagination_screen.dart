import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_5_login_logout_signup/screens/update_note_screen.dart';

import '../model/note.dart';

class PaginatedList extends StatefulWidget {
  const PaginatedList({super.key});

  @override
  State<PaginatedList> createState() => _PaginatedListState();
}

class _PaginatedListState extends State<PaginatedList> {
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
      //controller.position.pixels gives the current position
      //controller.position.maxScrollExtent it holds and returns the max value up to which we can scroll
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
        querySnapshot =
            (await ref.limit(10).get()) as QuerySnapshot<Map<String, dynamic>>?;
      } else {
        querySnapshot = (await ref
            .limit(10)
            .startAfterDocument(lastDocument!)
            .get()) as QuerySnapshot<Map<String, dynamic>>?;
      }

      if (querySnapshot!.docs.isNotEmpty) {
        // print("...........................");
        lastDocument = querySnapshot.docs.last;
      }

     final notes = querySnapshot.docs.map((e) => Note.fromMap(e)).toList();
     log(' this is list lenght${list.length.toString()}');
     log(' this is notez lenght${notes.length.toString()}');

     list.addAll(notes);
      //list.addAll(querySnapshot.docs.map((e) => e.data()));
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
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: controller,
            itemCount: list.length,
            itemBuilder: (context, index) {
              final note = list[index];
              // Map data = index.data!.docs[index].data() as Map;
              // DateTime? myDateTime = data['created'].toDate();
              // String formatedDateTime =
              //     DateFormat.yMMMd().add_jm().format(myDateTime!);
              return ListTile(
                onTap: () {
                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                      builder: (context) => UpdateNoteScreen(note: note,)
                    ),
                  )
                      .then((value) {
                    setState(() {});
                  });
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
    );
  }
}
