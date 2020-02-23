import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:room_finder/pages/settings.dart';
import 'package:room_finder/pages/home.dart';
import 'package:room_finder/theme/theme.model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyTheme>(
      create: (context) => MyTheme(),
      child: Consumer<MyTheme>(
        builder: (context, myTheme, child) {
          return MaterialApp(
            title: 'Main App',
            debugShowCheckedModeBanner: false,
            theme: myTheme.theme,
            initialRoute: '/',
            routes: {
              '/' : (context) => HomePage(),
              '/setting' : (context) => SettingPage(),
            },
          );
        },
      ),
    );
  }
}
