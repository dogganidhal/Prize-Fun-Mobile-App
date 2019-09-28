import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseUser, FirebaseAuth;
import 'package:flutter/services.dart';
import 'package:fun_prize/exceptions/auth.dart';


class AuthService {
  static String _usersCollection = "users";

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  Future<FirebaseUser> login({String email, String password}) async {
    try {
      final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password
      );
      return authResult.user;
    } on PlatformException catch (exception) {
      throw AuthException.fromPlatformException(exception);
    }
  }

  Future<FirebaseUser> signUp({
    String firstName, String lastName, String email,
    String username, String password
  }) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    await _firestore.collection(_usersCollection)
      .document(authResult.user.uid)
      .setData({
        "firstName": firstName,
        "lastName": lastName,
        "username": username,
        "email": email
      });
    return authResult.user;
  }

  Future<FirebaseUser> currentUser() => this._firebaseAuth.currentUser();

  Future<Null> logout() async {
    await _firebaseAuth.signOut();
  }
}