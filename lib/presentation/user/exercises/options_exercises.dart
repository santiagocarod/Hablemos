import 'package:flutter/material.dart';
import 'package:hablemos/ux/atoms.dart';

import '../../../constants.dart';
import 'helper/coming_soon.dart';

///Clase principal que contiene las diferentes opciones de ejercicios
///Las opciones de ejercicios posibles (por el momento) son:
///- `Quiero respirar`
///- `Mindfulness`
///- `Quiero meditar`
///
/// En caso de que el ejercicio se encuentre en desarrollo se muestra un cuadro explicandole al usuario
class OptionsExercises extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          child: _background(size),
        ),
        SafeArea(
          bottom: false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: crearAppBar('', null, 0, null, context: context),
            body: Center(
              child: Stack(
                children: <Widget>[
                  _opciones(context, size),
                ],
              ),
            ),
          ),
        ),
      ],
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
                  Icon(
                    Icons.favorite_border_outlined,
                    size: 50.0,
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
            colorButton('Mindfulness', () {
              // showCustomDialog(
              //   context,
              //   title: "Muy pronto",
              //   subTitle: "Esta sección se encuentra en desarrollo!",
              // );
              Navigator.pushNamed(context, 'mindfulness');
            }, kAmarilloMuyClaro, size * 0.9, 20.0),
            colorButton('Quiero meditar', () {
              showCustomDialog(
                context,
                title: "Muy pronto",
                subTitle: "Esta sección se encuentra en desarrollo!",
              );

              // Navigator.pushNamed(context, 'meditar');
            }, kRojoMuyClaro, size * 0.9, 20.0),
          ],
        ),
      ),
    );
  }
}
