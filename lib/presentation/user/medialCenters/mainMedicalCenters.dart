import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/ux/EncabezadoMedical.dart';
import 'package:hablemos/ux/atoms.dart';

//TODO: HACER LA CONSULTA A FIREBASE DESDE AQUI PARA QUE SOLO SE TENGA QUE HACE 1 VEZ Y DE RESTO PASARLA POR PARAMETRO
class MainMedicalCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: crearAppBar('', null, 0, null),
        body: SingleChildScrollView(
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
                                  context, "listCentrosMedicos"),
                              100.0)),
                      Container(
                          width: (size.width / 2) - 20,
                          child: ButtonMedicalCenters(
                              "Mapa\nCercanos", () {}, 100.0))
                    ]),
                SizedBox(height: size.height * 0.03),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ButtonMedicalCenters("Gratuitos", () {}, 100.0),
                      SizedBox(height: size.height * 0.03),
                      ButtonMedicalCenters("Pagos", () {}, 100.0),
                      SizedBox(height: size.height * 0.03),
                      ButtonMedicalCenters("Ciudad/Departamento", () {}, 100.0),
                      SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ],
            )));
  }
}

class ButtonMedicalCenters extends StatelessWidget {
  final String _text;
  final Function _function;
  final double heighButton;
  ButtonMedicalCenters(this._text, this._function, this.heighButton);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heighButton,
      child: ElevatedButton(
        onPressed: () => _function(),
        child: Text(
          _text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: kLetras, fontSize: 25, fontFamily: 'PoppinsRegular'),
        ),
        style: ElevatedButton.styleFrom(
            primary: kBlanco,
            elevation: 5,
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
