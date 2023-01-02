import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateTaskScreen extends StatefulWidget {
  final String id;
  final String title;
  final String description;

   const UpdateTaskScreen({super.key, required this.id, required this.title, required this.description});

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  final _titleController = TextEditingController();
  final _textController = TextEditingController();

  // ignore: non_constant_identifier_names
  Future AddText() async {
    AddTaskDetails(_titleController.text.trim(), _textController.text.trim());

    Navigator.pop(context);
  }

  // ignore: non_constant_identifier_names
  Future AddTaskDetails(String noteTitle, String noteDetails) async {
    await FirebaseFirestore.instance.collection('tasks').doc(widget.id).update({
      'title': noteTitle,
      'description': noteDetails,
    });
  }

  @override
  void initState() {
    _titleController.text = widget.title;
    _textController.text = widget.description;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //note title field
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          hintText: "Note title",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),

                //note description
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextField(
                        controller: _textController,
                        decoration: const InputDecoration(
                          hintText: "Note descriptiion ",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),

                //add task button

                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 105),
                  child: GestureDetector(
                    onTap: AddText,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                          child: Text(
                        "update Note",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      )),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
