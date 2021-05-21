import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hablemos/ux/atoms.dart';
import '../constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Clase que usamos para el diseño superior de los medical centeres en administrador
/// De esta forma evitamos repetir codigo en pantallas donde esto no va a cambiar

class EncabezadoMedicalAdmin extends StatelessWidget {
  const EncabezadoMedicalAdmin({
    Key key,
    @required this.size,
    this.text1,
    this.fontSize,
  }) : super(key: key);

  final Size size;
  final String text1;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.33,
      width: size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: [kAzul3, kBlanco]),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          )),
      child: Stack(
        children: <Widget>[
          Container(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.05,
                ),
                Icon(
                  FontAwesomeIcons.handHoldingMedical,
                  color: kLetras,
                  size: 80.0,
                ),
                Espacio(size: size),
                Text(
                  this.text1,
                  style: TextStyle(
                      fontSize: this.fontSize == null ? 30 : this.fontSize,
                      color: kLetras,
                      fontFamily: 'PoppinsRegular'),
                )
              ],
            )),
          ),
        ],
      ),
    );
  }
}
