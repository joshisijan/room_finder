import 'package:flutter/material.dart';


//Colors for theme
//Color lightPrimary = Color(0xfffcfcff);
Color lightPrimary = Color(0xff0f52ba);
Color darkPrimary = Colors.black;
Color lightAccent = Colors.orange;
Color darkAccent = Colors.orangeAccent;
Color lightBG = Color(0xfffcfcff);
Color darkBG = Colors.black;

ThemeData lightTheme = ThemeData(
  backgroundColor: lightBG,
  primaryColor: lightPrimary,
  accentColor:  lightAccent,
  cursorColor: lightAccent,
  scaffoldBackgroundColor: lightBG,
  buttonColor: lightPrimary,
  appBarTheme: AppBarTheme(
    elevation: 0,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  backgroundColor: darkBG,
  primaryColor: darkPrimary,
  accentColor: darkAccent,
  scaffoldBackgroundColor: darkBG,
  cursorColor: darkAccent,
  appBarTheme: AppBarTheme(
    elevation: 0,
  ),
);
