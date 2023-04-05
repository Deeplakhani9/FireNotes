import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/homapage.dart';
import 'package:firebase/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/UIHelper.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
  ));
}

class Sinup extends StatefulWidget {
  const Sinup({Key? key}) : super(key: key);

  @override
  State<Sinup> createState() => _SinupState();
}

class _SinupState extends State<Sinup> {
  bool isActive = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  TextEditingController EmailController = TextEditingController();

  void checkvalues() {
    String email = EmailController.text.trim();
    String password = passwordController.text.trim();
    String cpassword = cpasswordController.text.trim();

    if (email == "" || password == "" || cpassword == "") {
      print("Please fill All the fields!");
      final snackBar = SnackBar(
        content: const Text('Please fill All the fields!'),
        backgroundColor: (Colors.black26),
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (password != cpassword) {
      print("Password do not match!");
      final snackBar = SnackBar(
        content: const Text('Password do not match!'),
        backgroundColor: (Colors.black26),
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      signup(email, password);
    }
  }

  void signup(String email, String password) async {
    UserCredential? credential;
    //UIHelper.showLoadingDialog(context, "Creating new account..");
    try {
      credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      UIHelper.showAlertDialog(
          context, "An error occured", e.message.toString());
    }
    if (credential != null) {
      String Uid = credential.user!.uid;
      UserModel newUser = UserModel(
        Uid: Uid,
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection("users")
          .doc(Uid)
          .set(newUser.toMap())
          .then((value) {
        print("New User Created!");
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return FireNotes();
          }),
        );
      });
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
                    "Create Your FireNotes Account",
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
                    controller: EmailController,
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
                    controller: passwordController,
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
                  TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter your password..";
                      }
                      return null;
                    },
                    controller: cpasswordController,
                    obscureText: (isActive == false) ? true : false,
                    decoration: InputDecoration(
                        hintText: 'Confirm password',
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
                      checkvalues();
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color(0xff511252),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffB19DD0),
                      side: BorderSide(color: Color(0xffA349A4), width: 2),
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
              "Already have an account?",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Log In",
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
