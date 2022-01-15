import 'package:flutter/material.dart';

// Class - PopUp
// Functionality - Simply displays a popup for when we want to alert the user of something, liked being logged out or following/unfollowing a manga.


class PopUp {
  static createAlert(BuildContext context, String action) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text(action),
        actions: [
          MaterialButton(onPressed: () {
            Navigator.of(context).pop();
          },
            child: Text("Ok"),
          )
        ],
      );
    });
  }
}