import 'package:confetti/confetti.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import '../../../constants.dart';

class BreatheClass extends StatefulWidget {
  @override
  _BreatheClassState createState() => _BreatheClassState();
}

class _BreatheClassState extends State<BreatheClass> {
  ConfettiController controller;
  int contador = 0;
  CountDownController _controllerTimer = CountDownController();
  bool _isPause = true;

  bool _isBreathing = false;
  double expand = 10;

  @override
  void initState() {
    super.initState();

    controller = ConfettiController(duration: Duration(seconds: 4));
  }

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
        ),
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
        '¡Felicitaciones ! \n Terminaste el ejercicio',
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
                          'What is Lorem Ipsum?',
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
                          onPressed: playState,
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
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            CircularCountDownTimer(
              width: size.width * 0.25,
              height: size.height * 0.25,
              duration: 10,
              fillColor: Colors.amber,
              ringColor: Colors.white,
              controller: _controllerTimer,
              backgroundColor: Colors.blue,
              strokeWidth: expandLine(),
              strokeCap: StrokeCap.round,
              isReverse: false,
              textStyle: TextStyle(fontSize: 50.0, color: Colors.black),
              onComplete: playState,
            ),
            validarBoton(),
          ],
        ),
      ),
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
    contador = 60;
    setState(() {});
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

  double expandLine() {
    if (_isBreathing && expand == 15) {
      expand++;
      setState(() {});
      return expand;
    } else {
      expand--;
      setState(() {});
      return expand;
    }
  }

  Widget validarBoton() {
    if (_isPause) {
      return ElevatedButton(
        onPressed: () {
          setState(() {
            _isPause = true;
            _controllerTimer.start();
            contador = 0;
          });
        },
        child: Text('Empezar'),
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          setState(() {
            _isPause = false;
            _controllerTimer.start();
            contador = 0;
          });
        },
        child: Text('Reiniciar'),
      );
    }
  }
}
