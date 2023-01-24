import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../screens/update_note_screen.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  final user = FirebaseAuth.instance.currentUser!;

  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("tasks");

  List<Color> myColors = [
    Colors.yellow.shade200,
    Colors.red.shade200,
    Colors.green.shade200,
    Colors.deepPurple.shade200,
    Colors.purple.shade200,
    Colors.cyan.shade200,
    Colors.teal.shade200,
    Colors.tealAccent.shade200,
    Colors.pink.shade200,
  ];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: ref.get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              Random random = Random();
              Color bg = myColors[random.nextInt(myColors.length)];
              Map data = snapshot.data!.docs[index].data() as Map;

              DateTime? myDateTime = data['created'].toDate();
              String formatedDateTime =
                  DateFormat.yMMMd().add_jm().format(myDateTime!);

              return InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                      builder: (context) => UpdateNoteScreen(
                        data,
                        formatedDateTime,
                        snapshot.data!.docs[index].reference,
                      ),
                    ),
                  )
                      .then((value) {
                    setState(() {});
                  });
                },
                child: Card(
                  color: bg,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['title'].toString(),
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: "lato",
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        data['description'].toString(),
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: "lato",
                          color: Colors.black54,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          formatedDateTime,
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontFamily: "lato",
                            color: Colors.black54,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text("Loading notes...."),
          );
        }
      },
    );
  }
}
