import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedBox extends StatefulWidget {
  final List<int> seconds;
  final List<String> steps;

  const AnimatedBox({Key key, this.seconds, this.steps}) : super(key: key);

  @override
  _AnimatedBoxState createState() => _AnimatedBoxState();
}

class _AnimatedBoxState extends State<AnimatedBox> {
  List<int> segundos = [8, 5, 8, 5, 8];
  List<String> pasos = ["Inhala", "Manten", "Exala", "Manten", "Inhala"];
  double _width = 50.0;
  double _height = 50.0;
  Color _color = Colors.pink;
  BorderRadiusGeometry _borderRadiusGeometry = BorderRadius.circular(8.0);
  int i = 0;
  bool aguantar = false;
  bool primera = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                onEnd: () {
                  Timer(Duration(seconds: 1), () {
                    if (_height == 100) {
                      siguienteAnimacion(50.0, 50.0);
                    } else {
                      siguienteAnimacion(100.0, 100.0);
                    }
                  });
                },
                width: _width,
                height: _height,
                decoration: BoxDecoration(
                  borderRadius: _borderRadiusGeometry,
                  color: _color,
                ),
                duration: Duration(seconds: segundos[i]),
                curve: Curves.ease,
              ),
              SizedBox(
                height: 20,
              ),
              primera
                  ? Text("Preparárate")
                  : Text(
                      pasos[i],
                    ),
              primera
                  ? ElevatedButton(
                      onPressed: () {
                        startActividad();
                      },
                      child: Text("Empezar"),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  siguienteAnimacion(double cambioAlto, double cambioAncho) {
    var rng = new Random();

    if (i < pasos.length) {
      i += 1;
      setState(() {
        if (aguantar) {
          _color = Color.fromRGBO(rng.nextInt(255), rng.nextInt(255),
              rng.nextInt(255), rng.nextDouble());
          aguantar = false;
        } else {
          _height = cambioAlto;
          _width = cambioAncho;
          aguantar = true;
        }
      });
    }
  }

  startActividad() {
    var rng = new Random();
    primera = false;

    print("VALOR INDEX: $i");

    setState(() {
      _color = Color.fromRGBO(rng.nextInt(255), rng.nextInt(255),
          rng.nextInt(255), rng.nextDouble());
      _height = 100.0;
      _width = 100.0;
    });
  }
}
