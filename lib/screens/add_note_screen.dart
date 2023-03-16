import 'package:flutter/material.dart';
import 'package:flutter_application_5_login_logout_signup/auth/repository.dart';
import 'package:flutter_application_5_login_logout_signup/pages/home_page.dart';
import 'package:flutter_application_5_login_logout_signup/widgets/side_bar_menu.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _textController = TextEditingController();
  bool isArchive = false;

  // ignore: non_constant_identifier_names
  Future AddText() async {
    AddTaskDetails(_titleController.text.trim(), _textController.text.trim());

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  // ignore: non_constant_identifier_names
  Future AddTaskDetails(String noteTitle, String noteDetails) async {

    await Repository.instance.addNote(noteTitle, noteDetails, DateTime.now(), isArchive);
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
      appBar: AppBar(
        actions: [IconButton(onPressed: (){
          isArchive = !isArchive;
        }, icon: const Icon(Icons.chat_rounded))],
      ),
      drawer: const SideMenuBar(),
      body: SafeArea(
        
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //note title field
              const SizedBox(height: 50,),
              
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Note title'
                ),
              ),
              TextFormField(
                controller: _textController,
                decoration: const InputDecoration(
                  hintText: 'Note Description'
                ),
              ),
          
              //note description
              const SizedBox(
                height: 5,
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   child: Expanded(
              //     child: Container(height: 150,
              //       decoration: BoxDecoration(
              //           color: const Color.fromARGB(255, 152, 145, 145),
              //           border: Border.all(color: Colors.white),
              //           borderRadius: BorderRadius.circular(8.0)),
              //       child: Padding(
              //         padding: const EdgeInsets.only(left: 8.0),
              //         child: TextField(
              //           maxLines: null,
              //           // expands: true,
              //           controller: _textController,
              //           decoration: const InputDecoration(
              //             hintText: "Note descriptiion ",
              //             border: InputBorder.none,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
          
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
                      "Add Note",
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
    );
  }
}
