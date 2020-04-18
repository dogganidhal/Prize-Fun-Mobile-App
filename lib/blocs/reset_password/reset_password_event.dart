import 'package:equatable/equatable.dart';


abstract class ResetPasswordEvent extends Equatable {

}

class RequestResetCodeEvent extends ResetPasswordEvent {
  final String email;

  RequestResetCodeEvent({this.email});

  @override
  List<Object> get props => [email];
}

class ConfirmPasswordResetEvent extends ResetPasswordEvent {
  final String code;
  final String newPassword;

  ConfirmPasswordResetEvent({this.code, this.newPassword});

  @override
  List<Object> get props => [code, newPassword];
}