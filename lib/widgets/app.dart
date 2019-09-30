import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_prize/widgets/auth/auth.dart';
import 'package:fun_prize/widgets/prizes/prizes.dart';


class App extends StatelessWidget {
  final bool isAuthenticated;

  App({Key key, this.isAuthenticated});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "GoogleSans",
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 1,
          iconTheme: IconThemeData(
            color: Colors.blue
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.blue
          ),
          textTheme: Theme.of(context)
            .textTheme
            .copyWith(
              title: TextStyle(
                color: Colors.black,
                fontSize: 20
              )
            )
        ),
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: this.isAuthenticated ?
        Prizes() :
        Auth(
          postAuthWidgetBuilder: (context) => Prizes(),
        )
    );
  }
}