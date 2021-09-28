import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final CameraPosition cameraPosition = CameraPosition(
    target: LatLng(27.7172, 85.3240),
    zoom: 14.0,
  );

  final Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> markers = new Set();

  bool loading = false;

  bool showingBtn = false;

  getNearbyAds() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('ads').get();
    querySnapshot.docs.forEach((element) {
      markers.add(
        Marker(
            markerId: MarkerId(element.id.toString()),
            position: LatLng(element['lat'], element['lng']),
            infoWindow: InfoWindow(
              title: 'Rent: Rs.' + element['rent'].toString(),
              snippet: 'Deposit: Rs.' + element['deposit'].toString(),
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueViolet,
            ),
            onTap: () {
              setState(() {
                showingBtn = true;
              });
            }),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    getNearbyAds();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('markers' + markers.toString());
    return new Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniStartDocked,
      floatingActionButton: showingBtn
          ? MaterialButton(
              child: Text(
                'Show full room detail',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {},
            )
          : null,
      appBar: new AppBar(
        title: new Text('Maps'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0),
            child: loading
                ? Column(
                    children: [
                      Text(
                        'Loading nearby rooms...',
                        style: Theme.of(context).textTheme.overline,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      LinearProgressIndicator(),
                    ],
                  )
                : MaterialButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      'Show rooms nearby',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      await getNearbyAds();
                      setState(() {
                        loading = false;
                      });
                    },
                  ),
          ),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: cameraPosition,
        myLocationEnabled: true,
        markers: markers,
        onTap: (LatLng) {
          if (showingBtn) {
            setState(() {
              showingBtn = !showingBtn;
            });
          }
        },
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
      ),
    );
  }
}
