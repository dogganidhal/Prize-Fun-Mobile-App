import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';


@immutable
abstract class AuthEvent extends Equatable {
  AuthEvent([List props]) : super(props);
}

class LoadAuthEvent extends AuthEvent {

}

class SignUpEvent extends AuthEvent {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String password;
  final String graduationYear;
  final String program;

  SignUpEvent({
    this.email, this.password, this.lastName, this.firstName, this.username,
    this.graduationYear, this.program
  }) : super([email, password, firstName, lastName, username, graduationYear, program]);
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({this.email, this.password}) : super([email, password]);
}

class LogoutEvent extends AuthEvent {

}