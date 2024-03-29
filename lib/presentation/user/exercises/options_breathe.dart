import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/presentation/user/exercises/provider/ejerciciosEstaticos.dart';
import 'package:hablemos/ux/atoms.dart';

import 'animated_box.dart';
import 'helper/coming_soon.dart';

///Clase principal que contiene las diferentes opciones de `Quiero respirar`
///Las opciones de ejercicios posibles (por el momento) son:
/// - `Conectar con el presente`
/// - `Siento ansiedad`
/// - `Dormir`
///
/// En caso de que el ejercicio se encuentre en desarrollo se muestra un cuadro explicandole al usuario

class OptionsBreathe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: kVerdeMuyClaro,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: crearAppBar('', null, 0, null, context: context),
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                _inferior(context, size),
                _superior(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _superior(Size size) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.access_alarm_outlined,
              size: 60.0,
            ),
            SizedBox(height: 20.0),
            Text(
              'Quiero respirar',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                'Seleccciona lo que mejor se ajuste a tus necesidades',
                style: TextStyle(
                  fontSize: 25.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      width: size.width,
      height: size.height * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(30.0),
            bottomEnd: Radius.circular(30.0)),
        color: kVerdeMuyClaro,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 2.0),
          )
        ],
      ),
    );
  }

  Widget _inferior(BuildContext context, Size size) {
    return Container(
      width: size.width,
      height: size.height,
      child: Column(
        children: <Widget>[
          Container(
            width: size.width,
            height: size.height * 0.45,
          ),
          Container(
              height: size.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  colorButton('Conectar con el presente', () {
                    showCustomDialog(
                      context,
                      title: "Muy pronto",
                      subTitle: "Esta sección se encuentra en desarrollo!",
                    );

                    // Navigator.pushNamed(context, 'respirar');
                  }, kAzul1, size * 0.75, 50.0),
                  colorButton('Siento ansiedad', () {
                    showCustomDialog(
                      context,
                      title: "Muy pronto",
                      subTitle: "Esta sección se encuentra en desarrollo!",
                    );

                    // Navigator.pushNamed(context, 'respirar');
                  }, kAzul2, size * 0.75, 50.0),
                  colorButton('Dormir', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AnimatedBox(
                          instrucciones: dormirMejorInstrucciones,
                          numeroPaso: 0,
                        ),
                      ),
                    );
                  }, kAzul3, size * 0.75, 50.0),
                ],
              ))
        ],
      ),
    );
  }
}
