import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show AdditionalUserInfo,
  AuthResult, FirebaseAuth, FirebaseUser;
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart' show
  FacebookAuthCredential;
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fun_prize/exceptions/auth.dart';
import 'package:fun_prize/utils/concurrent.dart';


class AuthService {
  static String _kUsersCollection = "users";

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  final FacebookLogin _facebookLogin = FacebookLogin();

  Future<FirebaseUser> login({String email, String password}) async {
    try {
      AuthResult authResult = await delayed(_firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password
      ));
      if (!authResult.user.isEmailVerified) {
        throw new AuthException(
          "Vous n'avez pas confirmé votre adresse email, "
          "veuillez consulter votre boite pour retrouver le lien d'activation"
        );
      }
      return authResult.user;
    } on PlatformException catch (exception) {
      throw AuthException.fromPlatformException(exception);
    }
  }

  Future<void> signUp({
    String firstName, String lastName, String email,
    String username, String password
  }) async {
    final authResult = await delayed(_firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password
    ));
    await _firestore.collection(_kUsersCollection)
      .document(authResult.user.uid)
      .setData({
        "firstName": firstName,
        "lastName": lastName,
        "username": username,
        "email": email
      });
    authResult.user.sendEmailVerification();
  }

  Future<FirebaseUser> loginWithFacebook() async {
    final credentials = await _facebookLogin.logIn([
      "email"
    ]);
    if (credentials.status == FacebookLoginStatus.loggedIn) {
      try {
        final facebookCredential = FacebookAuthCredential(
          accessToken: credentials.accessToken.token);
        final firebaseCredential = await _firebaseAuth.signInWithCredential(
          facebookCredential);
        final usersSnapshot = await _firestore
          .collection(_kUsersCollection)
          .getDocuments();
        final userExists = usersSnapshot
          .documents
          .where((document) => document.documentID == firebaseCredential.user.uid)
          .isNotEmpty;
        if (!userExists) {
          await _firestore.collection(_kUsersCollection)
            .document(firebaseCredential.user.uid)
            .setData(_userFromFacebookProfile(firebaseCredential.additionalUserInfo));
        }
        return firebaseCredential.user;
      } on PlatformException catch (exception) {
        throw AuthException.fromPlatformException(exception);
      }
    }
    return null;
  }

  Future<Null> requestPasswordReset(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<Null> confirmPasswordReset(String code, String newPassword) async {
    await _firebaseAuth.confirmPasswordReset(code, newPassword);
  }

  Future<FirebaseUser> currentUser() => this._firebaseAuth.currentUser();

  Future<Null> logout() async {
    await _firebaseAuth.signOut();
  }

  Map<String, dynamic> _userFromFacebookProfile(AdditionalUserInfo userInfo) => {
    "firstName": userInfo.profile['first_name'],
    "lastName": userInfo.profile['last_name'],
    "username": userInfo.username ?? (userInfo.profile['email'] as String).split("@").first,
    "email": userInfo.profile['email']
  };
}