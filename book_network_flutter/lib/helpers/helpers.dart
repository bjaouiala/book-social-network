  import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromRGBO(96, 96, 96, 1),
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              
              child: const Text('OK',style: TextStyle(color: Colors.black),),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
