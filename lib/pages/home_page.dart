

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_5_login_logout_signup/screens/add_task_screen.dart';
import 'package:flutter_application_5_login_logout_signup/screens/update_task_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  //docment id's list
  List<String> docIDs = []; /////list to be stored in the firebase

  //task list
  List<String> task = [];

  //list of widgets
  List<Widget> widgetList = [];

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

  buildTile( String id,String title, String description, BuildContext context){
    return ListTile(
      title: Text(title),
      subtitle: Text(description),

      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return UpdateTaskScreen(id: id, title:title, description: description);
        },));
      },

      onLongPress: () {
        showDialog(context: context, builder: (context) => 
        Scaffold(body: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.5),
          child: Column(
            children: [
              const Text("Delete this note permanantly?"),
              const SizedBox(height: 10,),
              Center(
                child: IconButton(onPressed: () {
                  FirebaseFirestore.instance.collection("tasks").doc(id).delete().whenComplete(() {
                    Navigator.pop(context);
                  });
                }, icon: const Icon(Icons.delete_forever_rounded,
                color: Colors.redAccent,),),
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
        title: Text(
          user.email!,
          style: const TextStyle(fontSize: 15),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Icon(Icons.logout)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTaskScreen()));
        },
        backgroundColor: Colors.lightBlueAccent,
        child: const Icon(Icons.add),
      ),

      //body
      body: ListView(children: widgetList,),

/*       body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Column(
                
              ),

              /* FutureBuilder(
            future:
                getDocID(), /////////////////////////////////////////////////////////////////////////////
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: docIDs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: GetUserName(
                          documentId:
                              docIDs[index]), ////////////////////////////
                      tileColor: const Color.fromARGB(255, 216, 195, 255),
                    ),
                  );
                },
              );
            },
          ), */),
        ],
      )), */
    );
  }
}
          //in addition refer task_list file 
          //go through add_task_screen file
          //create a seperate task data file or just declare taskdata list
          //create a task screen
          //session management=> shared preference