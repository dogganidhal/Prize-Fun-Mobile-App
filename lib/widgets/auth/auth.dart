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
  final WidgetBuilder postAuthWidgetBuilder;

  const Auth({Key key, this.postAuthWidgetBuilder}) : super(key: key);

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
    _login = Login(
      onSignUpButtonTapped: () {
        setState(() => _authType = _AuthType.SIGN_UP);
      },
    );
    _signUp = SignUp(
      onLoginButtonTapped: () {
        setState(() => _authType = _AuthType.LOGIN);
      },
    );
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: BlocListener<AuthBloc, AuthState>(
      bloc: this._authBloc,
      listener: (context, state) {
        if (state.isLoading) {
          showLoader();
        } else {
          hideLoader();
        }
        if (state.exception != null) {
          showErrorModal(message: state.exception.message);
        }
        if (state.loginFinished) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: widget.postAuthWidgetBuilder
            ),
          );
        }
      },
      child: BlocProvider<AuthBloc>(
        create: (context) => this._authBloc,
        child: AnimatedSwitcher(
          key: _scaffoldBodyKey,
          duration: Duration(milliseconds: 200),
          child: _authType == _AuthType.LOGIN ? _login : _signUp
        ),
      ),
    ),
  );
}