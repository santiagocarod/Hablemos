import 'package:flutter/material.dart';

class AnimatedTimer extends StatefulWidget {
  final List<int> seconds;
  final List<String> pasos;

  const AnimatedTimer({Key key, this.seconds, this.pasos}) : super(key: key);

  @override
  _AnimatedTimerState createState() => _AnimatedTimerState();
}

class _AnimatedTimerState extends State<AnimatedTimer> {
  @override
  Widget build(BuildContext context) {
    List<int> segundos = [];
    List<String> pasos = [];

    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Sisi"),
        ),
      ),
    );
  }
}
