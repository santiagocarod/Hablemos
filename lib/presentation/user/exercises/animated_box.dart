import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedBox extends StatefulWidget {
  final int numeroPaso;
  final List<String> instrucciones;

  const AnimatedBox({Key key, this.numeroPaso, this.instrucciones})
      : super(key: key);

  @override
  _AnimatedBoxState createState() => _AnimatedBoxState();
}

class _AnimatedBoxState extends State<AnimatedBox> {
  double _width = 100.0;
  double _height = 100.0;
  Color _color = Colors.pink;
  BorderRadiusGeometry _borderRadiusGeometry = BorderRadius.circular(8.0);
  int i = 0;
  bool primera = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          child: _background(size),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedContainer(
                                onEnd: () {
                                  Timer(Duration(seconds: 2), () {
                                    siguienteAnimacion();
                                  });
                                },
                                width: _width,
                                height: _height,
                                decoration: BoxDecoration(
                                  borderRadius: _borderRadiusGeometry,
                                  color: _color,
                                ),
                                duration: Duration(seconds: 5),
                                curve: Curves.ease,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: size.height * 0.5,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: primera
                                  ? Text(
                                      widget.instrucciones[widget.numeroPaso])
                                  : Text(
                                      "Cuando lo consideres correcto ve al siguiente paso...."),
                            ),
                          ),
                          SizedBox(height: 20, width: double.infinity),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              child: primera
                                  ? ElevatedButton(
                                      onPressed: () {
                                        startActividad();
                                      },
                                      child: Text("Empezar"),
                                    )
                                  : ElevatedButton(
                                      onPressed: () {
                                        if (widget.numeroPaso <
                                            widget.instrucciones.length - 1) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => AnimatedBox(
                                                instrucciones: [
                                                  "Siéntate en una posición cómoda. Inhala y exhala profundamente",
                                                  "Ahora quiero que pienses en tres cosas por las que sientes gratitud de tu día desde lo personal. Piensa en la sonrisa de un ser querido, en lo bien que se sienten tus cobijas, en algo rico que comiste hoy. Permítete recrear en tu mente lo que sentiste, lo que oliste, lo que tocaste.",
                                                  "Ahora piensa en tres cosas por las que sientas gratitud en tu vida laboral o académica: la ayuda de un colega, una felicitación por algo que dijiste. Permítete recrear ese momento como lo recuerdas: con sus emociones, sus olores, sus colores, sus sensaciones.",
                                                  "Ahora piensa en tres partes de tu cuerpo o de tu personalidad por las que sientas gratitud: tu creatividad, tu cabello, tu estilo, tu voz, tus manos, tus gustos, lo que quieras. Piensa en esto que es tuyo y siente compasión y gratitud por ser el ser humano maravilloso que eres."
                                                ],
                                                numeroPaso:
                                                    widget.numeroPaso + 1,
                                              ),
                                            ),
                                          );
                                        } else {
                                          print("Show pop de terminacion");
                                        }
                                      },
                                      child: Text("Siguiente"),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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

  siguienteAnimacion() {
    var rng = new Random();

    setState(() {
      _color = Color.fromRGBO(
          rng.nextInt(230), rng.nextInt(230), rng.nextInt(230), 1);
      _width = rng.nextInt(300).toDouble();
      _height = rng.nextInt(300).toDouble();
      _borderRadiusGeometry =
          BorderRadius.circular(rng.nextInt(100).toDouble());
    });
  }

  startActividad() {
    var rng = new Random();
    primera = false;

    setState(() {
      _color = Color.fromRGBO(
          rng.nextInt(230), rng.nextInt(230), rng.nextInt(230), 1);
      _width = rng.nextInt(300).toDouble();
      _height = rng.nextInt(300).toDouble();
    });
  }
}
