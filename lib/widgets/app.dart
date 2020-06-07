import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_prize/blocs/auth/auth_bloc.dart';
import 'package:fun_prize/blocs/auth/auth_event.dart';
import 'package:fun_prize/blocs/auth/auth_state.dart';
import 'package:fun_prize/blocs/fun_point/fun_point_bloc.dart';
import 'package:fun_prize/blocs/fun_point/fun_point_event.dart';
import 'package:fun_prize/utils/constants.dart';
import 'package:fun_prize/widgets/auth/auth.dart';
import 'package:fun_prize/widgets/main.dart';


class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final AuthBloc _authBloc = AuthBloc();
  final FunPointBloc _funPointBloc = FunPointBloc();

  @override
  void initState() {
    super.initState();
    _authBloc.add(LoadAuthEvent());
  }

  @override
  void dispose() {
    _authBloc.close();
    _funPointBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => _authBloc,
      child: BlocProvider<FunPointBloc>(
        create: (context) => _funPointBloc,
        child: MaterialApp(
          theme: PFTheme.kLightTheme,
          darkTheme: PFTheme.kDarkTheme,
          home: BlocBuilder<AuthBloc, AuthState>(
            bloc: _authBloc,
            builder: (context, state) {
              if (state.isAuthenticated) {
                return Main();
              }
              return Auth();
            }
          ),
        ),
      ),
    );
  }
}