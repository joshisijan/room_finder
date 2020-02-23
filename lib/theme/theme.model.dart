import 'package:flutter/material.dart';
import 'package:room_finder/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyTheme extends ChangeNotifier{

  bool darkMode = false;
  ThemeData theme = lightTheme;

  MyTheme(){
    getDarkThemeValue();
  }

  void getDarkThemeValue()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int isDark = prefs.getInt('darkMode') ?? 0;
    if(isDark == 0){
      darkMode = false;
      theme = lightTheme;
      notifyListeners();
    }else{
      darkMode = true;
      theme = darkTheme;
      notifyListeners();
    }
  }

  void setThemeData(bool x)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(x == false){
      darkMode = false;
      await prefs.setInt('darkMode', 0);
      getDarkThemeValue();
      notifyListeners();
    }else{
      darkMode = true;
      await prefs.setInt('darkMode', 1);
      getDarkThemeValue();
      notifyListeners();
    }
  }
}