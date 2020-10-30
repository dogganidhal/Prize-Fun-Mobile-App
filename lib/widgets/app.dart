import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_prize/blocs/auth/auth_bloc.dart';
import 'package:fun_prize/blocs/auth/auth_event.dart';
import 'package:fun_prize/blocs/auth/auth_state.dart';
import 'package:fun_prize/blocs/fun_point/fun_point_bloc.dart';
import 'package:fun_prize/blocs/fun_point/fun_point_event.dart';
import 'package:fun_prize/blocs/navigation/navigation_bloc.dart';
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
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => _authBloc
        ),
        BlocProvider<FunPointBloc>(
          create: (context) => _funPointBloc
        ),
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(
            navigatorState: _navigatorKey
          )
        )
      ],
      child: MaterialApp(
        theme: PFTheme.kLightTheme,
        darkTheme: PFTheme.kDarkTheme,
        navigatorKey: _navigatorKey,
        debugShowCheckedModeBanner: false,
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
    );
  }
}
