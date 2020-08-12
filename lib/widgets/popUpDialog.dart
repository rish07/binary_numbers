import 'package:flutter/material.dart';

void popDialog({String title, BuildContext context, String content, Function onPress, String buttonTitle}) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: Center(
            child: Text(
          title,
          style: TextStyle(color: Colors.black),
        )),
        content: Text(
          content,
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              color: Colors.black,
              child: new Text(
                buttonTitle,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: onPress),
        ],
      );
    },
  );
}
