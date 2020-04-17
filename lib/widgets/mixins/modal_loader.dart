import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin ModalLoaderMixin<T extends StatefulWidget> on State<T> {

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
            Platform.isIOS ?
              CupertinoActivityIndicator() :
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor)
              ),
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