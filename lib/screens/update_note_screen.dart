import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'notification_screen.dart';

class UpdateNoteScreen extends StatefulWidget {
  final Map data1;
  final String time;
  final DocumentReference ref;

  const UpdateNoteScreen(this.data1, this.time, this.ref, {super.key});

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  TextEditingController titletexteditingController = TextEditingController();
  TextEditingController descriptiontexteditingController =
      TextEditingController();

  bool edit = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void initState() {
    titletexteditingController.text = widget.data1['title'];
    descriptiontexteditingController.text = widget.data1['description'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //
        floatingActionButton: edit
            ? FloatingActionButton(
                onPressed: save,
                backgroundColor: Colors.grey[700],
                child: const Icon(
                  Icons.save_rounded,
                  color: Colors.white,
                ),
              )
            : null,
        //
        resizeToAvoidBottomInset: false,
        //
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(
              12.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.grey[700],
                        ),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                            horizontal: 25.0,
                            vertical: 8.0,
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_outlined,
                        size: 24.0,
                      ),
                    ),
                    //
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              edit = !edit;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.grey[700],
                            ),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 8.0,
                              ),
                            ),
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 24.0,
                          ),
                        ),
                        //
                        const SizedBox(
                          width: 8.0,
                        ),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SetNotification(
                                    title: 'Add Notification',
                                  ),
                                ));
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.grey[700],
                            ),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 8.0,
                              ),
                            ),
                          ),
                          child: const Icon(
                            Icons.notification_add,
                            size: 24.0,
                          ),
                        ),
                        //
                        ElevatedButton(
                          onPressed: delete,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.red[300],
                            ),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 8.0,
                              ),
                            ),
                          ),
                          child: const Icon(
                            Icons.delete_forever,
                            size: 24.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //
                const SizedBox(
                  height: 12.0,
                ),
                //
                Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: titletexteditingController,
                        decoration: const InputDecoration.collapsed(
                          hintText: "Title",
                        ),
                        style: const TextStyle(
                          fontSize: 32.0,
                          fontFamily: "lato",
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        // initialValue: widget.data1['title'],
                        enabled: edit,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Can't be empty !";
                          } else {
                            return null;
                          }
                        },
                      ),
                      //
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12.0,
                          bottom: 12.0,
                        ),
                        child: Text(
                          widget.time,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontFamily: "lato",
                            color: Colors.grey,
                          ),
                        ),
                      ),

                      //

                      TextFormField(
                        controller: descriptiontexteditingController,
                        decoration: const InputDecoration.collapsed(
                          hintText: "Note Description",
                        ),
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontFamily: "lato",
                          color: Colors.grey,
                        ),
                        // initialValue: widget.data1['description'],
                        enabled: edit,
                        maxLines: 20,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Can't be empty !";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void delete() async {
    // delete from db
    await widget.ref.delete();
  }

  void save() async {
    if (key.currentState!.validate()) {
      // TODo : showing any kind of alert that new changes have been saved
      await widget.ref.update(
        {
          'title': titletexteditingController.text,
          'description': descriptiontexteditingController.text
        },
      );
    }
  }
}
