import 'package:confetti/confetti.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/ux/atoms.dart';

import '../../../constants.dart';

class BreatheClass extends StatefulWidget {
  @override
  _BreatheClassState createState() => _BreatheClassState();
}

class _BreatheClassState extends State<BreatheClass> {
  ConfettiController controller;
  int contador = 60;

  @override
  void initState() {
    super.initState();

    controller = ConfettiController(duration: Duration(seconds: 4));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBar('', null, 0, null),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: _blancoAtras(size),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: _superior(size),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: buildConfetti(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _inferior(size),
          ),
          Align(
            alignment: Alignment.center,
            child: _medio(size),
          ),
        ],
      ),
    );
  }

  Widget _blancoAtras(Size size) {
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.white,
    );
  }

  Widget _superior(Size size) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _textoPantalla(),
            SizedBox(height: size.height * 0.15)
          ],
        ),
      ),
      width: size.width,
      height: size.height * 0.5,
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

  Widget _textoPantalla() {
    if (contador == 60) {
      return Text(
        '¡ Felicitaciones ! \n Terminaste el ejercicio',
        style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      );
    } else {
      return Text(
        'Respiremos',
        style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _inferior(Size size) {
    return Container(
      height: size.height * 0.49,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              height: size.height * 0.25,
              width: size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(30.0),
                  bottomEnd: Radius.circular(30.0),
                  topStart: Radius.circular(30.0),
                  topEnd: Radius.circular(30.0),
                ),
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
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Holi',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 1.0),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s.',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          child: Text('Siguiente'),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }

  Widget _medio(Size size) {
    return Container(
      height: size.height * 0.35,
      width: size.width * 0.6,
      child: Align(alignment: Alignment.center, child: Text('oooo')),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(30.0),
          bottomEnd: Radius.circular(30.0),
          topStart: Radius.circular(30.0),
          topEnd: Radius.circular(30.0),
        ),
        color: Colors.white,
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

  void playState() {
    controller.play();
  }

  Widget buildConfetti() {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: controller,
        colors: [
          kAzulOscuro,
          kLetras,
          kBeigeFondo,
          kRojoOscuro,
          kRosado,
          kBlanco,
          kAmarillo,
          kAzulClaro,
          kMorado,
          kVerdeClaro,
          kMostaza,
          kAguaMarina,
          kMarino,
          kNegro,
          kVerde,
          kRojo,
          kVerdeMuyClaro,
          kAmarilloMuyClaro,
          kRojoMuyClaro,
          kAzul1,
          kAzul2,
          kAzul3,
        ],
        //shouldLoop: true,
        emissionFrequency: 0.5,
        numberOfParticles: 3,
        blastDirectionality: BlastDirectionality.explosive,
        gravity: 0.1,
        maxBlastForce: 2,
        minBlastForce: 1,
      ),
    );
  }
}
