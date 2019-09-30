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
      return authResult.user;
    } on PlatformException catch (exception) {
      throw AuthException.fromPlatformException(exception);
    }
  }

  Future<FirebaseUser> signUp({
    String firstName, String lastName, String email,
    String username, String password, String year
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
        "email": email,
        "year": year
      });
    return authResult.user;
  }

  Future<FirebaseUser> currentUser() => this._firebaseAuth.currentUser();

  Future<Null> logout() async {
    await _firebaseAuth.signOut();
  }
}