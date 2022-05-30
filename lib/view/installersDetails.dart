import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  final double lat;
  final double lng;

  const MapSample({super.key, required this.lat, required this.lng});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  late CameraPosition googleMapAffichage;
  getCurrentLoc() async {
    

    //coordoner obtenue grace a Geolocator
    double lat = widget.lat;
    double long = widget.lng;

    googleMapAffichage = CameraPosition(
      target: LatLng(lat, long),
      zoom: 14,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        onPressed: _goToTheInstalller,
        label: const Text('Find Installer'),
        icon: const Icon(Icons.navigation),
      ),
    );
  }

  Future<void> _goToTheInstalller() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(googleMapAffichage!));
  }
}
