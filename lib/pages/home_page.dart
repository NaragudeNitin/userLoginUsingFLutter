import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_5_login_logout_signup/readdata/get_user_name.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  //docment id's list
  List<String> docIDs = [];

  //get doc id's
  Future getDocID() async {
    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            }));
  }

/*   @override
  void initState(){
    getDocID();
    super.initState();
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.email!,
          style: TextStyle(fontSize: 15),
        ),
        actions: [GestureDetector(
          onTap: () {
            FirebaseAuth.instance.signOut();
          },
          child: Icon(Icons.logout))],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: FutureBuilder(
            future: getDocID(),
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: docIDs.length,
                itemBuilder: (context, index) {
                  return  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: GetUserName(documentId: docIDs[index]),
                      tileColor: Color.fromARGB(255, 216, 195, 255),
                    ),
                  );
                },
              );
            },
          ))
        ],
      )),
    );
  }
}

/* MaterialButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            color: Colors.deepPurple[200],
            child: const Text("Sign out"),
          ), */