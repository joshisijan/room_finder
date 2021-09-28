import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:room_finder/src/providers/post_location_provider.dart';

class PostMapSelector extends StatelessWidget {
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Tap on map to choose location',
              style: Theme.of(context).textTheme.overline,
            ),
          ),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: cameraPosition,
        myLocationEnabled: true,
        onMapCreated: (controller) async {
          _controller.complete(controller);
          Position currentPosition = await Geolocator.getCurrentPosition();
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target:
                    LatLng(currentPosition.latitude, currentPosition.longitude),
                zoom: 16,
              ),
            ),
          );
        },
        onTap: (latLng) async {
          await context.read<PostLocationProvider>().setLatLng(latLng);
          Navigator.pop(context);
        },
      ),
    );
  }
}
