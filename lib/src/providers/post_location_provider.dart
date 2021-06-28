import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PostLocationProvider extends ChangeNotifier {
  LatLng _seletedLocation;

  //getters
  LatLng get getSelectedLocation => _seletedLocation;

  //setters
  setLatLng(LatLng value) {
    _seletedLocation = value;
    notifyListeners();
  }
}
