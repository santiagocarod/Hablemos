import 'package:flutter/material.dart';
import 'package:hablemos/presentation/professional/letters/mainLettersPro.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MapBoxClass extends StatefulWidget {
  @override
  _MapBoxClassState createState() => _MapBoxClassState();
}

class _MapBoxClassState extends State<MapBoxClass> {
  MapboxMapController mapController;

  final center = LatLng(4.6097100, -74.0817500);

  String selectedStyle = 'mapbox://styles/nlopez113/ckmfe61zidis817p8e6480p12';
  final oscuroStyle = 'mapbox://styles/nlopez113/ckmfe46ir235h17o2wnev8907';
  final blancoStyle = 'mapbox://styles/nlopez113/ckmfe61zidis817p8e6480p12';

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(
        body: Center(
          child: Text('Web app'),
        ),
      );
    } else {
      return Scaffold(
        appBar: createAppBar(),
        body: Center(
          child: crearMapa(),
        ),
        floatingActionButton: crearZoomInOut(),
      );
    }
  }

  MapboxMap crearMapa() {
    return MapboxMap(
      styleString: selectedStyle,
      onMapCreated: _onMapCreated,
      onStyleLoadedCallback: () => addCircle(mapController),
      initialCameraPosition: CameraPosition(
        target: center,
        zoom: 11,
      ),
    );
  }

  Column crearZoomInOut() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        //Zoom in
        FloatingActionButton(
          child: Icon(Icons.zoom_in),
          onPressed: () {
            mapController.animateCamera(CameraUpdate.zoomIn());
          },
        ),
        SizedBox(height: 10),

        //Zoom out
        FloatingActionButton(
          child: Icon(Icons.zoom_out),
          onPressed: () {
            mapController.animateCamera(CameraUpdate.zoomOut());
          },
        ),

        SizedBox(height: 10),

        //Zoom out
        FloatingActionButton(
          child: Icon(Icons.gps_fixed),
          onPressed: () {
            //Mover a posicion actual
            mapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: center,
                  zoom: 13,
                ),
              ),
            );

            // Agreagr al mapa
            // mapController.addSymbol(
            //   SymbolOptions(
            //     geometry: center,
            //     textField: 'Tú',
            //   ),
            // );
          },
        ),
      ],
    );
  }

  AppBar createAppBar() {
    if (selectedStyle == oscuroStyle) {
      return AppBar(
        backgroundColor: Colors.black,
        actions: [
          Center(
            child: Text(
              'Modo Blanco',
              style: TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.nightlight_round,
              color: Colors.white,
            ),
            onPressed: () {
              selectedStyle = blancoStyle;
              setState(() {});
            },
          ),
        ],
      );
    } else {
      return AppBar(
        backgroundColor: Colors.white,
        actions: [
          Center(
            child: Text(
              'Modo Oscuro',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.nightlight_round,
              color: Colors.black,
            ),
            onPressed: () {
              selectedStyle = oscuroStyle;
              setState(() {});
            },
          ),
        ],
      );
    }
  }

  void addCircle(MapboxMapController mapController) {
    mapController.addCircle(CircleOptions(
      geometry: LatLng(4.6097100, -74.0817500),
      circleColor: '#23d2aa',
      circleRadius: 15,
    ));
  }
}
