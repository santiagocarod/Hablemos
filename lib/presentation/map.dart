import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hablemos/model/taller.dart';
import 'package:hablemos/services/providers/eventos_provider.dart';
import 'package:hablemos/ux/atoms.dart';

class MapsClass extends StatefulWidget {
  @override
  _MapsClassState createState() => _MapsClassState();
}

class _MapsClassState extends State<MapsClass> {
  Taller taller = EventoProvider.getTaller();

  final LatLng fromPoint = LatLng(4.710562, -74.049722);
  final LatLng toPoint = LatLng(4.731874, -74.038527);

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(4.710562, -74.049722),
    zoom: 12,
  );

  static final CameraPosition _kPlace = CameraPosition(
      bearing: 0,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 0,
      zoom: 15);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: crearAppBar('', null, 0, null),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _createMarkers(),
      ),
    );
  }

  // Future<void> _goToThePlace() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kPlace));
  // }

  Set<Marker> _createMarkers() {
    var tmp = Set<Marker>();

    tmp.add(Marker(
      markerId: MarkerId("fromPoint"),
      position: fromPoint,
      infoWindow: InfoWindow(
        title: "Mi casa",
      ),
    ));
    tmp.add(Marker(
      markerId: MarkerId("toPoint"),
      position: toPoint,
      infoWindow: InfoWindow(
        title: "Casa abelino",
      ),
    ));
    return tmp;
  }
}
