import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_prize/blocs/auth/auth_bloc.dart';
import 'package:fun_prize/blocs/auth/auth_event.dart';
import 'package:fun_prize/blocs/auth/auth_state.dart';
import 'package:fun_prize/utils/contants.dart';
import 'package:fun_prize/widgets/auth/auth.dart';
import 'package:fun_prize/widgets/main.dart';


class App extends StatelessWidget {
  final AuthBloc _authBloc = AuthBloc();

  App({Key key}) {
    _authBloc.add(LoadAuthEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => _authBloc,
      child: MaterialApp(
        theme: PFTheme.kLightTheme,
        darkTheme: PFTheme.kDarkTheme,
        home: BlocBuilder<AuthBloc, AuthState>(
          bloc: _authBloc,
          builder: (context, state) {
            if (state.isAuthenticated) {
              return Main();
            }
//            if (state.isLoading) {
//              return Center(
//                child: CircularProgressIndicator(),
//              );
//            }
            return Auth();
          }
        ),
      ),
    );
  }
}