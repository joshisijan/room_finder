import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  final CameraPosition cameraPosition = CameraPosition(
    target: LatLng(27.7172, 85.3240),
    zoom: 14.0,
  );

  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Maps'),
      ),
      body: GoogleMap(
        initialCameraPosition: cameraPosition,
        myLocationButtonEnabled: true,
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
