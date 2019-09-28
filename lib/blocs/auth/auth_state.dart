import 'package:firebase_auth/firebase_auth.dart' show FirebaseUser;
import 'package:fun_prize/exceptions/auth.dart' show AuthException;


class AuthState {
  bool finished;
  bool isInitialized;
  bool isLoading;
  bool isFormValid;
  FirebaseUser user;
  AuthException exception;

  bool get isAuthenticated => this.user != null;

  AuthState({
    this.isInitialized = false, this.isLoading = false, this.isFormValid = false,
    this.user, this.exception, this.finished = false
  });

  AuthState get copy => AuthState(
    isFormValid: this.isFormValid,
    isLoading: this.isLoading,
    isInitialized: this.isInitialized,
    user: this.user,
    exception: this.exception,
    finished: this.finished
  );

  @override
  bool operator ==(other) {
    if (other is AuthState) {
      return other.exception == this.exception &&
        other.isInitialized == this.isInitialized &&
        other.isLoading == this.isLoading &&
        other.isFormValid == this.isFormValid &&
        other.user == this.user &&
        other.finished == this.finished;
    }
    return super == other;
  }

  @override
  int get hashCode => this.hashCode;
}