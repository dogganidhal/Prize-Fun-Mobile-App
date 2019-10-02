import 'package:flutter/material.dart';


mixin ErrorModalMixin<T extends StatefulWidget> on State<T> {

  void showErrorModal({String title, String message}) {
    showDialog(
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () => Future.value(false),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4)
          ),
          title: Text(title ?? "Erreur"),
          content: Padding(
            padding: EdgeInsets.all(16),
            child: Text(message),
          ),
          actions: <Widget>[
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4)
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            )
          ],
        ),
      )
    );
  }

}