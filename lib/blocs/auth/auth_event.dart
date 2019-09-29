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
  final String year;

  SignUpEvent({
    this.email, this.password, this.lastName, this.firstName, this.username,
    this.year
  }) : super([email, password, firstName, lastName, username, year]);
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({this.email, this.password}) : super([email, password]);
}