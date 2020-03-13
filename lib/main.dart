import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:room_finder/pages/login.dart';

import 'package:room_finder/pages/settings.dart';
import 'package:room_finder/pages/home.dart';
import 'package:room_finder/theme/theme.dart';
import 'package:room_finder/theme/theme.model.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return ChangeNotifierProvider<MyTheme>(
      create: (context) => MyTheme(),
      child: Consumer<MyTheme>(
        builder: (context, myTheme, child) {
          return MaterialApp(
            title: 'Main App',
            debugShowCheckedModeBanner: false,
            theme: myTheme.theme,
            darkTheme: darkTheme,
            home: StreamBuilder(
              stream: FirebaseAuth.instance.onAuthStateChanged,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }else{
                  if(snapshot.hasData){
                    return HomePage();
                  }else{
                    return LoginPage();
                  }
                }
              },
            ),
            routes: {
              '/home' : (context) => HomePage(),
              '/setting' : (context) => SettingPage(),
              '/login' : (context) => LoginPage(),
            },
          );
        },
      ),
    );
  }
}




