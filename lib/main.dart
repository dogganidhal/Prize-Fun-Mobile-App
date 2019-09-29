import 'package:flutter/material.dart';
import 'package:fun_prize/service/auth_service.dart';
import 'package:fun_prize/widgets/app.dart';


void main() async {
  final user = AuthService().currentUser();
  runApp(App(isAuthenticated: user != null));
}