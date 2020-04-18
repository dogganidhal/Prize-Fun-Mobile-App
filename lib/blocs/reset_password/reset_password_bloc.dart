import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_prize/blocs/reset_password/reset_password_event.dart';
import 'package:fun_prize/blocs/reset_password/reset_password_state.dart';
import 'package:fun_prize/exceptions/auth.dart';
import 'package:fun_prize/service/auth_service.dart';


class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final AuthService _authService = AuthService();

  @override
  ResetPasswordState get initialState => ResetPasswordState(
    isLoading: false,
    exception: null
  );

  @override
  Stream<ResetPasswordState> mapEventToState(ResetPasswordEvent event) async* {

    if (event is RequestResetCodeEvent) {
      yield ResetPasswordState(
        isLoading: true,
        exception: null
      );
      try {
        await _authService.requestPasswordReset(event.email);
        yield PasswordResetSuccessfulState();
      } on PlatformException catch (exception) {
        yield ResetPasswordState(
          isLoading: false,
          exception: AuthException.fromPlatformException(exception)
        );
      }
    }

  }
}