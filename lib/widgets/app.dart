import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_prize/blocs/auth/auth_bloc.dart';
import 'package:fun_prize/utils/contants.dart';
import 'package:fun_prize/widgets/auth/auth.dart';
import 'package:fun_prize/widgets/prizes/prizes.dart';


class App extends StatelessWidget {
  final bool isAuthenticated;

  App({Key key, this.isAuthenticated});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      builder: (context) => AuthBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "GoogleSans",
          primaryColor: Constants.primaryColor,
          colorScheme: ColorScheme.light(
            primary: Constants.primaryColor
          ),
          inputDecorationTheme: InputDecorationTheme(
            fillColor: Constants.primaryColor,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Constants.primaryColor,
              ),
              borderRadius: BorderRadius.circular(4)
            ),
            focusColor: Constants.primaryColor,
          ),
          appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 1,
            iconTheme: IconThemeData(
              color: Constants.primaryColor
            ),
            actionsIconTheme: IconThemeData(
              color: Constants.primaryColor
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
          cursorColor: Constants.primaryColor,
        ),
        home: this.isAuthenticated ?
          Prizes() :
          Auth(
            postAuthWidgetBuilder: (context) => Prizes(),
          )
      ),
    );
  }
}