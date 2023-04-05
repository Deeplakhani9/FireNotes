import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'global.dart';
import 'note_reader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
    ),
  );
}

class FireNotes extends StatefulWidget {
  const FireNotes({Key? key}) : super(key: key);

  @override
  State<FireNotes> createState() => _FireNotesState();
}

class _FireNotesState extends State<FireNotes> {
  final CollectionReference ref =
      FirebaseFirestore.instance.collection('notes');
  List data = [];
  final GlobalKey<FormState> notesKey = GlobalKey<FormState>();
  final GlobalKey<FormState> editNoteKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subTitleController = TextEditingController();
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: Color(0xffEDD3ED),
      appBar: AppBar(
        title: Text(
          "FireNotes",
          style: TextStyle(
            color: Color(0xffC785C8),
          ),
        ),
        backgroundColor: Color(0xff511252),
      ),
      body: Center(
        child: StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error :- ${snapshot.error} ",
                  style: TextStyle(color: Colors.purple.shade500),
                ),
              );
            } else if (snapshot.hasData) {
              data = snapshot.data!.docs;

              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (_, i) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => readerscreen(
                                  docToEdit: snapshot.data?.docs[i]),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            //    color: Global.cardsColor[i],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.purple.shade600,
                              width: 2,
                            ),
                          ),
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data?.docs[i]["title"],
                                //snapshot.data.documents[i].data['title'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data?.docs[i]["content"],
                                // snapshot.data!.documents[i].data['content'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${Global.date}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13),
                                      ),
                                      Text(
                                        "${Global.time}",
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          tooltip: "Add Note",
          onPressed: () {
            Navigator.of(context).pushNamed('typenotes');
          },
          child: Icon(
            Icons.note_add,
            size: 30,
          )),
    );
  }
}
