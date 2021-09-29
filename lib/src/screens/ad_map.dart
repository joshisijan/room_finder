import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AdMap extends StatelessWidget {
  final LatLng latlng;
  AdMap({
    @required this.latlng,
  });
  final CameraPosition cameraPosition = CameraPosition(
    target: LatLng(27.7172, 85.3240),
    zoom: 14.0,
  );

  final Set<Marker> markers = new Set();

  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    markers.add(Marker(
      markerId: MarkerId('House Location' +
          latlng.latitude.toString() +
          latlng.longitude.toString()),
      position: latlng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      infoWindow: InfoWindow(
        title: 'House\'s location',
        snippet: 'The location of house you selected',
      ),
    ));
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Maps'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'The house is located in this location',
              style: Theme.of(context).textTheme.overline,
            ),
          ),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: cameraPosition,
        myLocationEnabled: true,
        markers: markers,
        onMapCreated: (controller) async {
          _controller.complete(controller);
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(latlng.latitude, latlng.longitude),
                zoom: 16,
              ),
            ),
          );
        },
      ),
    );
  }
}
