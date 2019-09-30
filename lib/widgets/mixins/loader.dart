import 'package:flutter/material.dart';

mixin LoaderMixin<T extends StatefulWidget> on State<T> {

  bool _isLoaderVisible = false;

  void showLoader() {
    _isLoaderVisible = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
        ),
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.amber)),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text("Chargement ..."),
            )
          ],
        ),
      )
    );
  }

  void hideLoader() {
    if (_isLoaderVisible) {
      Navigator.of(context).pop();
      _isLoaderVisible = false;
    }
  }

}