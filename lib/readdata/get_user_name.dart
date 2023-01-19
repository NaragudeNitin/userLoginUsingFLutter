import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String documentId;

  const GetUserName({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    //get the collection
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> datai =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(" ${datai['first name']}"
              " "
              "${datai['last name']},"
              "${datai['age']} years old");
        }
        return const Text("loading...");
      },
    );
  }
}

/**
 * in this page create one cloud fire base and call collection to the fire store
 */


