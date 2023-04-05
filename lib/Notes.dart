import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'global.dart';

class typenotes extends StatefulWidget {
  const typenotes({Key? key}) : super(key: key);

  @override
  State<typenotes> createState() => _typenotesState();
}

class _typenotesState extends State<typenotes> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> notesKey = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: notesKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${Global.date}",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${Global.time}",
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                TextFormField(
                  controller: title,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  textInputAction: TextInputAction.next,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Note Title",
                    hintStyle:
                        TextStyle(fontSize: 20, color: Colors.grey.shade600),
                  ),
                ),
                TextFormField(
                  controller: content,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "please enter notes";
                    }
                    return null;
                  },
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  cursorColor: Colors.white,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    hintText: "Type something....",
                    hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.purple,
        onPressed: () async {
          ref.add({
            'title': title.text,
            'content': content.text,
          }).whenComplete(() => Navigator.pop(context));
        },
        label: Text("Save"),
        icon: Icon(Icons.save),
      ),
      backgroundColor: Colors.purple.shade100,
      // backgroundColor: Global.cardsColor[color_id],
    );
  }
}
