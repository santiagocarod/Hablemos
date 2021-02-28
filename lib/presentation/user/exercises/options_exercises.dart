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
      appBar: crearAppBar(
          'Ejercicios', Icons.favorite_border_outlined, 0, kVerdeClaro),
      body: Center(
        child: Stack(
          children: <Widget>[
            _background(size),
            _opciones(),
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

  Widget _opciones() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[],
      ),
    );
  }
}
