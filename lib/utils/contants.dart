import 'package:flutter/material.dart';


abstract class Constants {
  static String logoAsset = "assets/logo.png";
}

abstract class PFTheme {

  static final kLightPrimaryColor = Color(0xFFFE5657);
  static final kLightAccentColor = Color(0xFFFE5657);
  static final kDarkPrimaryColor = Color(0xFFfc6f70);
  static final kDarkAccentColor = Color(0xFFfc6f70);
  static final kDarkColor = Color(0xFF171717);
  static final kDarkGrayColor = Color(0xFF272727);
  static final kLightColor = Color(0xFFFDFDFD);
  static final kErrorColor = Color(0xFFFF3C38);

  static final kLightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: kLightPrimaryColor,
    accentColor: kLightAccentColor,
    errorColor: kErrorColor,
    cursorColor: kLightPrimaryColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: kLightAccentColor,
      elevation: 1
    ),
    colorScheme: ColorScheme.light(
      primary: kLightPrimaryColor,
      background: kLightColor,
      brightness: Brightness.dark
    ),
    fontFamily: 'GoogleSans',
    scaffoldBackgroundColor: kLightColor,
    backgroundColor: kLightColor,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: kLightColor,
      iconTheme: IconThemeData(
        color: kLightPrimaryColor
      ),
      textTheme: TextTheme(
        title: TextStyle(
          color: kDarkColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'GoogleSans'
        )
      ),
      brightness: Brightness.light,
    )
  );

  static final kDarkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: kDarkAccentColor,
    errorColor: kErrorColor,
    colorScheme: ColorScheme.dark(
      primary: kDarkPrimaryColor,
      brightness: Brightness.light,
    ),
    splashColor: kDarkColor.withOpacity(0.4),
    fontFamily: 'GoogleSans',
    backgroundColor: kDarkColor,
    scaffoldBackgroundColor: kDarkColor,
    cursorColor: kDarkPrimaryColor,
    textTheme: TextTheme(
      body1: TextStyle(
        color: kLightColor,
      ),
      display1: TextStyle(
        color: kLightColor
      )
    ),
    accentColor: kDarkAccentColor,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: kDarkColor.withAlpha(200),
      iconTheme: IconThemeData(
        color: kDarkPrimaryColor
      ),
      textTheme: TextTheme(
        title: TextStyle(
          color: kLightColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'GoogleSans'
        )
      ),
      brightness: Brightness.dark,
    ),
    cardTheme: CardTheme(
      color: kDarkGrayColor
    ),
    canvasColor: kDarkGrayColor
  );

}