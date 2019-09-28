import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_prize/blocs/auth/auth_bloc.dart';
import 'package:fun_prize/blocs/auth/auth_event.dart';
import 'package:fun_prize/blocs/auth/auth_state.dart';
import 'package:fun_prize/widgets/auth/auth.dart';
import 'package:fun_prize/widgets/home.dart';


class App extends StatelessWidget {
  final AuthBloc _authBloc = AuthBloc();

  App({Key key}) : super(key: key) {
    this._authBloc.dispatch(LoadAuthEvent());
  }

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
        )
      ),
      home: BlocProvider<AuthBloc>(
        builder: (context) => this._authBloc,
        child: BlocBuilder<AuthBloc, AuthState>(
          bloc: this._authBloc,
          builder: (context, state) {
            if (!state.isInitialized) {
              return Container(
                color: Colors.white,
                child: Center(
                  child: Platform.isIOS ?
                    CupertinoActivityIndicator() :
                    CircularProgressIndicator(),
                ),
              );
            }
            if (!state.isAuthenticated) {
              return Auth(
                postAuthWidgetBuilder: (context) => Home(),
              );
            }
            return Home();
          },
        ),
      )
    );
  }
}