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
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: lightAccent,
  ),
  scaffoldBackgroundColor: lightBG,
  colorScheme: ThemeData.light().colorScheme.copyWith(
        secondary: lightAccent,
      ),
  appBarTheme: AppBarTheme(
    elevation: 0,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  backgroundColor: darkBG,
  primaryColor: darkPrimary,
  colorScheme: ThemeData.light().colorScheme.copyWith(
        secondary: lightAccent,
      ),
  scaffoldBackgroundColor: darkBG,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: darkAccent,
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
  ),
);
