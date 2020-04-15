import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';


@immutable
abstract class AuthEvent extends Equatable {

}

class LoadAuthEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class SignUpEvent extends AuthEvent {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String password;

  SignUpEvent({
    this.email, this.password, this.lastName, this.firstName, this.username
  });

  @override
  List<Object> get props => [email, password, firstName, lastName, username];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}

class LogoutEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class LoginWithFacebookEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}