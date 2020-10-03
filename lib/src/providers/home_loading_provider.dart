import 'package:flutter/material.dart';

class HomeLoadingProvider extends ChangeNotifier {

  //loading state
  bool _loading = false;

  //getters
  bool get getLoading => _loading;

  //setters
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}