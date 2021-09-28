import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatelessWidget {
  final CameraPosition cameraPosition = CameraPosition(
    target: LatLng(27.7172, 85.3240),
    zoom: 14.0,
  );

  final Completer<GoogleMapController> _controller = Completer();

  final location = Location();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Maps'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_on),
        onPressed: () {},
      ),
      body: GoogleMap(
        initialCameraPosition: cameraPosition,
        myLocationEnabled: true,
        onMapCreated: (controller) {
          _controller.complete(controller);
          location.onLocationChanged.listen((location) {
            controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(location.latitude, location.longitude),
                    zoom: 14)));
          });
        },
      ),
    );
  }
}
