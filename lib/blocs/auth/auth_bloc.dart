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

    if (event is SignUpEvent) {
      yield state.copy
        ..isLoading = true;
      try {
        await authService.signUp(
          firstName: event.firstName,
          lastName: event.lastName,
          email: "${event.email}${Constants.audenciaEmailSuffix}",
//          email: "${event.email}@gmail.com",
          username: event.username,
          password: event.password,
          graduationYear: event.graduationYear,
          program: event.program
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
          email: "${event.email}${Constants.audenciaEmailSuffix}",
//          email: "${event.email}@gmail.com",
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
}