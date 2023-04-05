import 'dart:async';

import 'package:flutter/material.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed('loging');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffB19DD0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   "assets/image/1_ti5CnGh_T4Kqy5aCTLJRcg.png",
            //   height: 300,
            //   width: 300,
            // ),
            Stack(
              children: [
                Image.asset(
                  "assets/image/firenotes.png",
                  height: 200,
                  width: 200,
                ),
              ],
            ),
            Text(
              "FireNotes",
              style: TextStyle(
                  color: Color(0xff511252),
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
