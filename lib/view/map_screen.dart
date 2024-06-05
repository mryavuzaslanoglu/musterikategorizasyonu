import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  final Set<Marker> _markers = {};


  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.1778784831711, 33.25428723439747),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();

    _markers.add(
      const Marker(
        markerId: MarkerId('macho_ahi'),
        position: LatLng(37.1778784831711, 33.25428723439747),
        infoWindow: InfoWindow(title: 'Macho Ahi'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _initialPosition, // Başlangıç konumunu kullanın
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    // Marker konumuna yakınlaştır
    controller.animateCamera(CameraUpdate.newCameraPosition(_initialPosition));
  }
}
