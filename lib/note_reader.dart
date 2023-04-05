import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'global.dart';

class readerscreen extends StatefulWidget {
  late DocumentSnapshot docToEdit;
  readerscreen({
    required this.docToEdit,
    Key? key,
  }) : super(key: key);

  @override
  State<readerscreen> createState() => _readerscreenState();
}

class _readerscreenState extends State<readerscreen> {
  final GlobalKey<FormState> notesKey = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  void initState() {
    // title = TextEditingController(text: widget.docToEdit.data['title']);
    // content = TextEditingController(text: widget.docToEdit.data['content']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff511252),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              onPressed: () {
                widget.docToEdit.reference
                    .delete()
                    .whenComplete(() => Navigator.pop(context));
              },
              icon: Icon(Icons.delete)),
        ],
        elevation: 0,
      ),
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
          widget.docToEdit.reference.update({
            'title': title.text,
            'content': content.text,
          }).whenComplete(() => Navigator.pop(context));
        },
        label: Text("Update"),
        icon: Icon(Icons.edit),
      ),

      // Padding(
      //   padding: const EdgeInsets.all(16),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text(
      //         widget.doc["note_title"],
      //         style: Global.main,
      //       ),
      //       SizedBox(
      //         height: 4,
      //       ),
      //       Text(
      //         widget.doc['creation_date'],
      //         style: Global.ddtaTitle,
      //       ),
      //       SizedBox(
      //         height: 28,
      //       ),
      //       Text(
      //         widget.doc['note_content'],
      //         style: Global.maincontent,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
