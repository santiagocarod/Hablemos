import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hablemos/ux/atoms.dart';

///Clase principal de los mapas, la cual maneja todos los metodos y movimientos de camara
///que necesite el mapa para que el usuario pueda trabajar correctamente

class MapBoxClass extends StatefulWidget {
  @override
  _MapBoxClassState createState() => _MapBoxClassState();
}

class _MapBoxClassState extends State<MapBoxClass> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (kIsWeb) {
      return SafeArea(
        child: Scaffold(
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
                      '¡No te preocupes!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '¡Actualmente no esta implementada esta pantalla para ver el mapa automaticamente!',
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
        ),
      );
    } else {
      return Stack(
        children: [
          Container(
            child: Image.asset(
              'assets/images/yellowBack.png',
              alignment: Alignment.center,
              fit: BoxFit.fill,
              width: size.width,
              height: size.height,
            ),
          ),
          SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar:
                  crearAppBar('GoogleMaps', null, 0, null, context: context),
              body: Stack(
                children: [
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
                            '¡No te preocupes!',
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
            ),
          ),
        ],
      );
    }
  }
}
