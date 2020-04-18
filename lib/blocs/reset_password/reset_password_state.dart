import 'package:equatable/equatable.dart';
import 'package:fun_prize/exceptions/auth.dart';


class ResetPasswordState extends Equatable {
  final bool isLoading;
  final AuthException exception;

  ResetPasswordState({this.isLoading, this.exception});

  @override
  List<Object> get props => [isLoading, exception];
}

class PasswordResetSuccessfulState extends ResetPasswordState {
  @override
  List<Object> get props => [];
}