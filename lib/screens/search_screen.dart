import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_5_login_logout_signup/model/note.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List searchResult = [];
  List<Note> items = [];
  List<Note> filterNotes = [];

  @override
  void initState() {
    fetchNotes();
    super.initState();
  }

  void fetchNotes()async{
    final result = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('tasks')
        .get();

        // print(result.docs.length);
        

        final documents = result.docs;

        items = result.docs.map((e) => Note.fromMap(e)).toList();
        // for (QueryDocumentSnapshot element in documents) {
        
        //   // print(".....................//////");
        //   final data = element.data() as Map<String, dynamic>;

        //   final title = data['title'];
        //   final description = data['description'];
        //   final note = Note(title: title, description: description, isArchived: false);
        //   items.add(note);

        //   // print(data['title']);

        // }
  }

  void searchFromFirebase(String query) async {
    
    setState(() {
      filterNotes = items.where((note) => note.title.contains(query)).toList();
    });
  }

  final TextEditingController searchController = TextEditingController();
  late QuerySnapshot snapshotData;
  late bool isExecuted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'Search here',
          ),
          style: const TextStyle(color: Colors.black54),
          onChanged: (query) {
            searchFromFirebase(query);
          },
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: ListView.builder(
        itemCount: filterNotes.length,
        itemBuilder: (context, index) {
          final note = filterNotes[index];
          return ListTile(
            title: Text(note.title),
            subtitle: Text(note.description),
          );
        },
      ),
      backgroundColor: Colors.black26,
    );
  }
}