import 'package:flutter/material.dart';
import 'package:hablemos/ux/atoms.dart';

import '../../../constants.dart';

class OptionsExercises extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBar('', null, 0, null),
      body: Center(
        child: Stack(
          children: <Widget>[
            _background(size),
            _opciones(context, size),
          ],
        ),
      ),
    );
  }

  Widget _background(Size size) {
    return Image.asset(
      'assets/images/exercisesBack.png',
      alignment: Alignment.center,
      fit: BoxFit.fill,
      width: size.width,
      height: size.height,
    );
  }

  Widget _opciones(BuildContext context, Size size) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  Hero(
                    tag: heroActividades,
                    child: Icon(
                      Icons.favorite_border_outlined,
                      size: 50.0,
                    ),
                  ),
                  Text(
                    'Ejercicios',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'assets/fonts/Poppins-Regular.ttf',
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            colorButton('Quiero respirar', () {
              Navigator.pushNamed(context, 'opcionesRespirar');
            }, kVerdeMuyClaro, size * 0.9, 20.0),
            colorButton(
                'Mindfulness', () {}, kAmarilloMuyClaro, size * 0.9, 20.0),
            colorButton(
                'Quiero meditar', () {}, kRojoMuyClaro, size * 0.9, 20.0),
          ],
        ),
      ),
    );
  }
}
