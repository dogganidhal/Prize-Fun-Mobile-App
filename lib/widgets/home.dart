import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text("Fun & Prize"),
        centerTitle: true,
      ),
      body: Center(
        child: FlatButton(
          child: Text("Se déconnecter"),
          onPressed: () => FirebaseAuth.instance.signOut(),
        ),
      ),
    );
  }
}