import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_5_login_logout_signup/screens/add_note_screen.dart';
import 'package:flutter_application_5_login_logout_signup/screens/update_note_screen.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final TextEditingController _textEditingController = TextEditingController();

  //
  CollectionReference ref = FirebaseFirestore.instance
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection(
      "tasks");

  //List of colors
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

  //docment id's list
  List<String> docIDs = []; /////list to be stored in the firebase

  //task list
  List<String> task = [];

  //list of widgets
  List<Widget> widgetList = [];
  //List for onsearch
  List<Widget> widgetListOnSearch = [];

  @override
  void initState() {
    getTaskDetails();
    super.initState();
  }

  //get task details
  Future getTaskDetails() async {
    await FirebaseFirestore.instance.collection("tasks").get().then(
      (snapshot) {
        for (var element in snapshot.docs) {
          // ignore: avoid_print
          print(element.id);
          task.add(element.reference.id);
          final title = element["title"];
          final description = element["description"];
          final id = element.id;

          // final datas = buildTile(element.reference, context);
          final data = buildTile(id, title, description, context);
          widgetList.add(data);
        }
        setState(() {});
      },
    );
  }

  //building a tile to update and delete the data
  buildTile(String id, String title, String description, BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(description),
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(
        //   builder: (context) {
        //     return UpdateNoteScreen(
        //         id: id, title: title, description: description);
        //   },
        // ));
      },
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) => Scaffold(
                    body: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.5),
                  child: Column(
                    children: [
                      const Text("Delete this note permanantly?"),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: IconButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection("tasks")
                                .doc(id)
                                .delete()
                                .whenComplete(() {
                              Navigator.pop(context);
                            });
                          },
                          icon: const Icon(
                            Icons.delete_forever_rounded,
                            color: Colors.redAccent,
                          ),
                        ),
                      )
                    ],
                  ),
                )));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: Colors.blue.shade200,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                // widgetListOnSearch = widgetList.where((element) => element.Contains(value).toList());
                // widgetListOnSearch = widgetList.where((element) => element.contains(value)).toList();
              });
            },
            controller: _textEditingController,
            decoration: const InputDecoration(
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 100),
                hintText: 'search'),
          ),
        ),
      ),

      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  Text(
                    user.email!,
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                children: const [
                  Text(
                    'Logout',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  Icon(Icons.logout)
                ],
              ),
              // iconColor: Colors.redAccent,
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTaskScreen(),
              ),
              )
              .then((value) {
                stdout.writeln("calling setstate");
                setState(() {
                  
                });
              });
        },
        backgroundColor: Colors.lightBlueAccent,
        child: const Icon(Icons.add),
      ),

      //body

      body: FutureBuilder<QuerySnapshot>(
        future: ref.get(),

        builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              Random random = Random();
              Color bg =myColors[random.nextInt(myColors.length)];
              Map data = snapshot.data!.docs[index].data() as Map;

              
              
              DateTime? myDateTime = data['created'].toDate();
              String formatedDateTime = /* DateFormat('yyyy-mm-dd').format(myDateTime!); */ DateFormat.yMMMd().add_jm().format(myDateTime!);
              
            return InkWell(
/*               onTap: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => UpdateNoteScreen(
                          data,
                          formatedDateTime,
                          snapshot.data!.docs[index].reference, data: const {}, ref: null,
                        ),
                      ),
                    )
                        .then((value) {
                      setState(() {});
                    });
                  }, */

              // onTap: Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdateNoteScreen(id: ,title: , description: ),)),
              child: Card(
                color: bg,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(data['title'].toString(),
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontFamily: "lato",
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    ),
            
                    Text(data['description'].toString(),
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontFamily: "lato",
                      color: Colors.black54,
                    ),
                    ),
                    
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text( formatedDateTime,
                      style: const TextStyle(
                      fontSize: 12.0,
                      fontFamily: "lato",
                      color: Colors.black54,
                    ),
                      ),)
                  ],
                ),
              ),
            );
          },);
        }else{
          return const Center(child: Text("Loading notes...."),);
        }
      },),



      /* body: ListView(
        children: widgetList,
      ), */
    );
  }
}
         /**
          * Wrrap the card with Inkwell......then
          *  in addition refer task_list file 
          *  go through add_task_screen file
          *  create a seperate task data file or just declare taskdata list
          *  create a task screen
          *  session management=> shared preference
          *  do google login
          *  do social login
          *  CURD operation
          *  search bar
          *  show only user related data 
          *  like show the notes for particular user only 
          *  data must no be mixed with the other users data
          *
          */

          /**
           * Inkwell(
           * ontap: (){
           * Navigator.of(context).push(MaterialPageRoute(
           *  builder: (context)=> updatetask(),
           * ),);
           * }
           * )
           */