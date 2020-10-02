import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:room_finder/src/screens/login.dart';
import 'package:room_finder/src/styles/theme.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      title: 'Main App',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: LoginPage(),
    );
  }
}