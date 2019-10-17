import 'package:firebase_auth/firebase_auth.dart' show FirebaseUser;
import 'package:fun_prize/exceptions/auth.dart' show AuthException;


class AuthState {
  bool loginFinished;
  bool signUpFinished;
  bool isInitialized;
  bool isLoading;
  bool isFormValid;
  FirebaseUser user;
  AuthException exception;

  bool get isAuthenticated => this.user != null;

  AuthState({
    this.isInitialized = false, this.isLoading = false, this.isFormValid = false,
    this.user, this.exception, this.loginFinished = false,
    this.signUpFinished = false
  });

  AuthState get copy => AuthState(
    isFormValid: this.isFormValid,
    isLoading: this.isLoading,
    isInitialized: this.isInitialized,
    user: this.user,
    exception: this.exception,
    loginFinished: this.loginFinished,
    signUpFinished: this.signUpFinished
  );

  @override
  bool operator ==(other) {
    if (other is AuthState) {
      return other.exception == this.exception &&
        other.isInitialized == this.isInitialized &&
        other.isLoading == this.isLoading &&
        other.isFormValid == this.isFormValid &&
        other.user == this.user &&
        other.loginFinished == this.loginFinished &&
        other.signUpFinished == this.signUpFinished;
    }
    return super == other;
  }

  @override
  int get hashCode => this.hashCode;
}