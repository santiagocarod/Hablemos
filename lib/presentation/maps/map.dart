import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:geolocator/geolocator.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geocoder/geocoder.dart';

class MapBoxClass extends StatefulWidget {
  @override
  _MapBoxClassState createState() => _MapBoxClassState();
}

class _MapBoxClassState extends State<MapBoxClass> {
  Position _currentPosition;
  String _currentAddress;
  double dirLatitud;
  double dirLongitud;

  LatLng center = LatLng(4.6097100, -74.0817500);

  @override
  Widget build(BuildContext context) {
    String direccion = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;

    if (kIsWeb) {
      return Scaffold(
        body: Center(
          child: Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Container(
                    height: 300,
                    width: 300,
                    child: Image.asset(
                      'assets/images/gmaps.png',
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Text(
                    'No te preocupes!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Actualmente no esta implementada esta pantalla para ver el mapa automaticamente!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Te recomendamos copiar y pegar este link: ',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    child: Text(
                      'https://www.google.com/maps',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: crearAppBar('GoogleMaps', null, 0, null),
        body: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              child: Image.asset(
                'assets/images/yellowBack.png',
                alignment: Alignment.center,
                fit: BoxFit.fill,
                width: size.width,
                height: size.height,
              ),
            ),
            Container(
              child: FutureBuilder(
                future: _transformStreet(direccion),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    final info = snapshot.data;
                    openMap(
                        info.coordinates.latitude, info.coordinates.longitude);
                    return Container(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height * 0.1,
                            ),
                            Container(
                              height: 300,
                              width: 300,
                              child: Image.asset(
                                'assets/images/gmaps.png',
                                alignment: Alignment.center,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.1,
                            ),
                            Text(
                              'No te preocupes!',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 30),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Estamos abriendo google maps en',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '$direccion',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  _transformStreet(String direccion) async {
    List<Address> ltln;
    try {
      ltln = await Geocoder.local.findAddressesFromQuery(direccion);
    } catch (e) {
      print(e);
    }
    return ltln.first;
  }

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.street}";
        center = LatLng(_currentPosition.latitude, _currentPosition.longitude);
      });
    } catch (e) {
      print(e);
    }
  }
}
