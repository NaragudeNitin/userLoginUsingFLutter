import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PaginatedList extends StatefulWidget {
  const PaginatedList({super.key});

  @override
  State<PaginatedList> createState() => _PaginatedListState();
}

class _PaginatedListState extends State<PaginatedList> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("tasks");
  DocumentSnapshot? lastDocument;
  bool isMoreData = true;
  List<Map<String, dynamic>> list = [];
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

      list.addAll(querySnapshot.docs.map((e) => e.data()));
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
              // Map data = index.data!.docs[index].data() as Map;
              // DateTime? myDateTime = data['created'].toDate();
              // String formatedDateTime =
              //     DateFormat.yMMMd().add_jm().format(myDateTime!);
              return ListTile(
                onTap: () {
                  // Navigator.of(context)
                  //     .push(
                  //   MaterialPageRoute(
                  //     builder: (context) => UpdateNoteScreen(
                  //       list[index],
                  //       formatedDateTime,
                  //       snapshot.data!.docs[index].reference,
                  //     ),
                  //   ),
                  // )
                  //     .then((value) {
                  //   setState(() {});
                  // });
                },
                title: Text(list[index]['title'].toString()),
                subtitle: Text(list[index]['description'].toString()),
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
