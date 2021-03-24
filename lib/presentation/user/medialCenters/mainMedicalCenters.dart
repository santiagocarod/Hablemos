import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/ux/EncabezadoMedical.dart';
import 'package:hablemos/ux/atoms.dart';

class MainMedicalCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: crearAppBar('', null, 0, null),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                EncabezadoMedical(
                  size: size,
                  text1: "Canales de Ayuda",
                ),
                Espacio(size: size),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                          width: (size.width / 2) - 20,
                          child: ButtonMedicalCenters(
                              "Lista\nCercanos",
                              () => Navigator.pushNamed(
                                  context, "listCentrosMedicos"))),
                      Container(
                          width: (size.width / 2) - 20,
                          child: ButtonMedicalCenters("Mapa\nCercanos", () {}))
                    ]),
                Espacio(size: size),
                ButtonMedicalCenters("Gratuitos", () {}),
                Espacio(size: size),
                ButtonMedicalCenters("Pagos", () {}),
                Espacio(size: size),
                ButtonMedicalCenters("Ciudad/Departamento", () {}),
              ],
            )));
  }
}

class ButtonMedicalCenters extends StatelessWidget {
  final String _text;
  final Function _function;
  ButtonMedicalCenters(this._text, this._function);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _function(),
      child: Text(
        _text,
        textAlign: TextAlign.center,
        style: TextStyle(color: kLetras, fontSize: 34),
      ),
      style: ElevatedButton.styleFrom(
          primary: kBlanco,
          elevation: 10,
          padding: EdgeInsets.symmetric(vertical: 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
