import 'package:bloc/bloc.dart';
import 'package:fun_prize/blocs/auth/auth_event.dart';
import 'package:fun_prize/blocs/auth/auth_state.dart';
import 'package:fun_prize/service/auth_service.dart';
import 'package:fun_prize/exceptions/auth.dart';
import 'package:fun_prize/utils/contants.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService = AuthService();

  @override
  AuthState get initialState => AuthState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    final state = this.currentState;

    if (event is SignUpEvent) {
      yield state.copy
        ..isLoading = true;
      try {
        final user = await authService.signUp(
          firstName: event.firstName,
          lastName: event.lastName,
          email: "${event.email}${Constants.audenciaEmailSuffix}",
          username: event.username,
          password: event.password
        );
        yield state.copy
          ..isLoading = false
          ..user = user
          ..finished = true;
      } on AuthException catch (exception) {
        yield state.copy
          ..isLoading = false
          ..exception = exception;
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
          email: "${event.email}${Constants.audenciaEmailSuffix}",
          password: event.password
        );
        yield state.copy
          ..isLoading = false
          ..user = user
          ..finished = false;
      } on AuthException catch (exception) {
        yield state.copy
          ..isLoading = false
          ..exception = exception;
      }
    }

  }
}