import 'package:flutter/material.dart';

class UIHelper {
  static void showLoadingDialog(BuildContext context, String title) {
    AlertDialog loadingDialog = AlertDialog(
      content: Container(
        //color: Colors.purple,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 30,
            ),
            Text(title),
          ],
        ),
      ),
    );

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return loadingDialog;
        });
  }

  static void showAlertDialog(
      BuildContext context, String title, String content) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }
}
