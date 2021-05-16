import 'package:flutter/material.dart';

class AnimatedBox extends StatefulWidget {
  final List<int> seconds;
  final List<String> steps;

  const AnimatedBox({Key key, this.seconds, this.steps}) : super(key: key);

  @override
  _AnimatedBoxState createState() => _AnimatedBoxState();
}

class _AnimatedBoxState extends State<AnimatedBox> {
  @override
  Widget build(BuildContext context) {
    List<int> segundos = [20, 5, 20, 5];
    List<String> pasos = ["Paso 1", "Paso 2", "Paso 3", "Paso 4"];

    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Sisi"),
        ),
      ),
    );
  }
}
