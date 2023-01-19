/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GridViewPage extends StatefulWidget {
  const GridViewPage({super.key});

  @override
  State<GridViewPage> createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
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
    return FutureBuilder(
      future: ref.get(),
      builder: (context, snapshot) {
      return GridView(
        gridDelegate: )
    },);
  }
} */