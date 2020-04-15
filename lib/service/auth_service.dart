import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseUser, FirebaseAuth, AuthResult;
import 'package:flutter/services.dart';
import 'package:fun_prize/exceptions/auth.dart';
import 'package:fun_prize/utils/concurrent.dart';


class AuthService {
  static String _kUsersCollection = "users";

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

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

  Future<FirebaseUser> currentUser() => this._firebaseAuth.currentUser();

  Future<Null> logout() async {
    await _firebaseAuth.signOut();
  }
}