import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/sinup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homapage.dart';
import 'models/UIHelper.dart';
import 'models/helpar.dart';
import 'models/usermodel.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
  ));
}

class Logingpage extends StatefulWidget {
  const Logingpage({Key? key}) : super(key: key);

  @override
  State<Logingpage> createState() => _LogingpageState();
}

class _LogingpageState extends State<Logingpage> {
  bool isActive = false;
  TextEditingController loginpasswordController = TextEditingController();
  TextEditingController loginEmailController = TextEditingController();

  void checkValues() {
    String email = loginEmailController.text.trim();
    String password = loginpasswordController.text.trim();

    if (email == "" || password == "") {
      UIHelper.showAlertDialog(
          context, "Incomplete Data", "Please fill all the fields");
    } else {
      logIn(email, password);
    }
  }

  void logIn(String email, String password) async {
    UserCredential? credential;

    UIHelper.showLoadingDialog(context, "Logging In..");

    try {
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      // Close the loading dialog
      Navigator.pop(context);

      // Show Alert Dialog
      UIHelper.showAlertDialog(
          context, "An error occured", ex.message.toString());
    }

    if (credential != null) {
      String uid = credential.user!.uid;

      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      UserModel userModel =
          UserModel.fromMap(userData.data() as Map<String, dynamic>);

      // Go to HomePage
      print("Log In Successful!");
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return FireNotes();
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffB19DD0),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Log in Your FireNotes Account",
                    style: TextStyle(
                        color: Color(0xff511252),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Image.asset(
                    "assets/image/firenotes.png",
                    width: 200,
                    height: 200,
                  ),
                  TextFormField(
                    validator: (val) {
                      return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val!)
                          ? null
                          : "Please Enter Correct Email";
                    },
                    // validator: (val) {
                    //   if (val!.isEmpty) {
                    //     return "Enter your Email..";
                    //   }
                    //   return null;
                    // },
                    controller: loginEmailController,
                    decoration: InputDecoration(
                        hintText: 'Email', suffixIcon: Icon(Icons.email)),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a password!';
                      } else if (value.length < 6) {
                        return "Please provide password of 5+ character ";
                      }
                      return null;
                    },
                    // validator: (val) {
                    //   if (val!.isEmpty) {
                    //     return "Enter your password..";
                    //   }
                    //   return null;
                    // },
                    controller: loginpasswordController,
                    obscureText: (isActive == false) ? true : false,
                    decoration: InputDecoration(
                        hintText: 'password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isActive = !isActive;
                            });
                          },
                          icon: (isActive == false)
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        )),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      checkValues();
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        color: Color(0xff511252),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffB19DD0),
                      side: BorderSide(color: Color(0xffA349A4), width: 2),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      "--------------------------------- OR ---------------------------------"),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      Map<String, dynamic> res = await Firebase_auth_helper
                          .firebase_auth_helper
                          .signWithGoogle();

                      if (res['user'] != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Sign In successful..."),
                            backgroundColor: Colors.black26,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );

                        Navigator.of(context)
                            .pushReplacementNamed('/', arguments: res['user']);
                      } else if (res['error'] != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(res['error']),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff511252), width: 2),
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffEDD3ED),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                              "assets/image/google-removebg-preview.png"),
                          Text(
                            "Log in With Google",
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account?",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            CupertinoButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return Sinup();
                  }),
                );
              },
              child: Text(
                "Sing up",
                style: TextStyle(
                  color: Color(0xff511252),
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
