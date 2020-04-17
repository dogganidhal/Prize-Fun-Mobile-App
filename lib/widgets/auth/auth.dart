import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_prize/blocs/auth/auth_bloc.dart';
import 'package:fun_prize/blocs/auth/auth_state.dart';
import 'package:fun_prize/widgets/auth/login.dart';
import 'package:fun_prize/widgets/auth/sign_up.dart';
import 'package:fun_prize/widgets/mixins/error.dart';
import 'package:fun_prize/widgets/mixins/modal_loader.dart';

enum _AuthType {
  LOGIN, SIGN_UP
}

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> with ModalLoaderMixin, ErrorModalMixin {
  AuthBloc _authBloc;
  GlobalKey _scaffoldBodyKey = GlobalKey();
  
  _AuthType _authType = _AuthType.LOGIN;
  Login _login;
  SignUp _signUp;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _login = Login(
      authBloc: _authBloc,
      onSignUpButtonTapped: () {
        setState(() => _authType = _AuthType.SIGN_UP);
      },
    );
    _signUp = SignUp(
      authBloc: _authBloc,
      onLoginButtonTapped: () {
        setState(() => _authType = _AuthType.LOGIN);
      },
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (context, state) {
        if (state.exception != null) {
          showErrorModal(message: state.exception.message);
        }
      },
      child: BlocProvider<AuthBloc>(
        create: (context) => _authBloc,
        child: BlocBuilder<AuthBloc, AuthState>(
          bloc: _authBloc,
          builder: (context, state) => Stack(
            children: <Widget>[
              if (state.isLoading)
                Positioned(
                  bottom: 0, left: 0, right: 0,
                  child: LinearProgressIndicator()
                ),
              AnimatedSwitcher(
                key: _scaffoldBodyKey,
                duration: Duration(milliseconds: 200),
                child: _authType == _AuthType.LOGIN ? _login : _signUp
              )
            ],
          ),
        ),
      ),
    ),
  );
}