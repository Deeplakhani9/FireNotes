import 'package:firebase/logingpage.dart';
import 'package:firebase/sinup.dart';
import 'package:firebase/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Notes.dart';
import 'homapage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(myapp());
}

class myapp extends StatelessWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "splash",
      routes: {
        "/": (context) => FireNotes(),
        'splash': (context) => splash(),
        'loging': (context) => Logingpage(),
        'sinup': (context) => Sinup(),
        'typenotes': (context) => typenotes(),
      },
    );
  }
}
