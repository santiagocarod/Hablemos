import 'package:flutter/material.dart';
import 'package:hablemos/ux/atoms.dart';

class ListMedicalCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: crearAppBar('Centros Medicos', null, 0, null),
        body: Stack(children: [
          Image.asset(
            'assets/images/yellowBack.png',
            alignment: Alignment.center,
            fit: BoxFit.fill,
            width: size.width,
            height: size.height,
          )
        ]));
  }
}
