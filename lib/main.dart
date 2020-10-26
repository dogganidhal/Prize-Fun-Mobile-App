import 'package:flutter/material.dart';
import 'package:fun_prize/widgets/app.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  SharedPreferences.setMockInitialValues({});
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}
