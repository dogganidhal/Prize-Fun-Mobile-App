import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';


@immutable
class User {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String address;
  final int age;
  final int funPoints;

  User({
    this.uid, this.firstName, this.lastName, this.email, this.username,
    this.age, this.address, this.funPoints
  });

  factory User.fromDocument(DocumentSnapshot document) => User(
    uid: document.documentID,
    firstName: document.data['firstName'],
    lastName: document.data['lastName'],
    email: document.data['email'],
    username: document.data['username'],
    address: document.data['address'],
    age: document.data['age'],
    funPoints: document.data['funPoints']
  );
}