import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hablemos/ux/atoms.dart';

class MapBoxClass extends StatefulWidget {
  @override
  _MapBoxClassState createState() => _MapBoxClassState();
}

class _MapBoxClassState extends State<MapBoxClass> {
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
                      'Estamos abriendo google maps en',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      );
    }
  }
}
