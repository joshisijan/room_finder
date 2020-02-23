import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:room_finder/functions/constants.dart';
import 'package:room_finder/theme/theme.model.dart';


class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: kDefaultPadding,
                ),
                Text('darktheme'),
                Consumer<MyTheme>(
                  builder:(context, myTheme, child){
                    return Switch(
                      value: myTheme.darkMode,
                      onChanged: (x){
                        myTheme.setThemeData(x);
                      },
                    );
                },
                ),
                SizedBox(
                  width: kDefaultPadding,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
