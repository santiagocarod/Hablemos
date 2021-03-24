import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hablemos/ux/atoms.dart';
import '../constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EncabezadoMedical extends StatelessWidget {
  const EncabezadoMedical({
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
      height: size.height * 0.4,
      width: size.width,
      decoration: BoxDecoration(
          color: kRosado,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(100),
            bottomRight: Radius.circular(100),
          )),
      child: Stack(
        children: <Widget>[
          Container(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.handHoldingMedical,
                  color: kLetras,
                  size: size.height * 0.15,
                ),
                Espacio(size: size),
                Text(
                  this.text1,
                  style: TextStyle(
                      fontSize: this.fontSize == null ? 36 : this.fontSize,
                      color: kLetras,
                      fontFamily: 'PoppinSemiBold'),
                )
              ],
            )),
          ),
        ],
      ),
    );
  }
}