import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart' show FacebookAuthCredential;
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fun_prize/blocs/auth/auth_event.dart';
import 'package:fun_prize/blocs/auth/auth_state.dart';
import 'package:fun_prize/service/auth_service.dart';
import 'package:fun_prize/exceptions/auth.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService = AuthService();
  final FacebookLogin facebookLogin = FacebookLogin();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  AuthState get initialState => AuthState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {

    if (event is LoginWithFacebookEvent) {
      yield state.copy
        ..isLoading = true;
      try {
        final user = await authService.loginWithFacebook();
        yield state.copy
          ..isLoading = false
          ..user = user
          ..loginFinished = true;
      } on AuthException catch (exception) {
        yield state.copy
          ..isLoading = false
          ..exception = exception;
        yield state.copy
          ..exception = null;
      }
    }

    if (event is SignUpEvent) {
      yield state.copy
        ..isLoading = true;
      try {
        await authService.signUp(
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          username: event.username,
          password: event.password,
        );
        yield state.copy
          ..isLoading = false
          ..signUpFinished = true;
        yield state.copy
          ..signUpFinished = false;
      } on AuthException catch (exception) {
        yield state.copy
          ..isLoading = false
          ..exception = exception;
        yield state.copy
          ..exception = null;
      }
    }

    if (event is LoadAuthEvent) {
      final user = await this.authService.currentUser();
      yield state.copy
        ..isInitialized = true
        ..user = user;
    }

    if (event is LoginEvent) {
      yield state.copy
        ..isLoading = true;
      try {
        final user = await this.authService.login(
          email: event.email,
          password: event.password
        );
        yield state.copy
          ..isLoading = false
          ..user = user
          ..loginFinished = true;
      } on AuthException catch (exception) {
        yield state.copy
          ..isLoading = false
          ..exception = exception;
        yield state.copy
          ..exception = null;
      }
    }

    if (event is LogoutEvent) {
      await authService.logout();
      yield state.copy
        ..user = null;
    }
  }

  signUp({
    String firstName, String lastName, String email,
    String username, String password
  }) {
    add(SignUpEvent(
      firstName: firstName,
      lastName: lastName,
      username: username,
      email: email,
      password: password
    ));
  }
}