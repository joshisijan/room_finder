import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_finder/pages/login.dart';

import 'package:room_finder/theme/theme.model.dart';


class SettingPage extends StatelessWidget {

  final FirebaseAuth _fbAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: _fbAuth.onAuthStateChanged,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Scaffold(
            appBar: AppBar(
              title: Text('Settings'),
            ),
            body: Container(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text('Dark mode'),
                    trailing: Consumer<MyTheme>(
                      builder:(context, myTheme, child){
                        return Switch(
                          value: myTheme.darkMode,
                          onChanged: (x){
                            myTheme.setThemeData(x);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }else{
          return LoginPage();
        }
      }
    );
  }
}
