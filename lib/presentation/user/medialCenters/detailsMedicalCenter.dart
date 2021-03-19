import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/ux/EncabezadoMedical.dart';
import 'package:hablemos/model/centro_atencion.dart';

class DetailsMedicalCenter extends StatelessWidget {
  final double _horizontalPadding = 25.0;
  @override
  Widget build(BuildContext context) {
    final CentroAtencion _centroAtencion =
        ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: crearAppBar("", null, 0, null),
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                EncabezadoMedical(
                  size: size,
                  text1: _centroAtencion.nombre,
                  fontSize: 22,
                ),
                Espacio(size: size),
                MedicalCenterDetailsTitle("Ubicación"),
                MedicalCenterDetailsInfo(_centroAtencion.ubicacion),
                //Espacio(size: size),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: _horizontalPadding),
                  child: Container(
                    height: 1.0,
                    color: kGrisN,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                        width: (size.width / 2) - 20,
                        child: MedicalCenterDetailsTitle("Departamento")),
                    Container(
                        width: (size.width / 2) - 20,
                        child: MedicalCenterDetailsTitle("Ciudad")),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                        width: (size.width / 2) - 20,
                        child: MedicalCenterDetailsInfo(
                            _centroAtencion.departamento)),
                    Container(
                        width: (size.width / 2) - 20,
                        child: Row(
                          children: [
                            MedicalCenterDetailsInfo(_centroAtencion.ciudad),
                            Icon(Icons.pin_drop)
                          ],
                        )),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: _horizontalPadding),
                  child: Container(
                    height: 1.0,
                    color: kGrisN,
                  ),
                ),

                Espacio(size: size),
                MedicalCenterDetailsTitle("Horario de Atención"),
                MedicalCenterDetailsInfo(_centroAtencion.horaAtencion),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: _horizontalPadding),
                  child: Container(
                    height: 1.0,
                    color: kGrisN,
                  ),
                ),
                Espacio(size: size),
                MedicalCenterDetailsTitle("Correo"),
                MedicalCenterDetailsInfo(_centroAtencion.correo),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: _horizontalPadding),
                  child: Container(
                    height: 1.0,
                    color: kGrisN,
                  ),
                ),
                Espacio(size: size),
                MedicalCenterDetailsTitle("Telefonos"),
                MedicalCenterDetailsInfo(_centroAtencion.telefono),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: _horizontalPadding),
                  child: Container(
                    height: 1.0,
                    color: kGrisN,
                  ),
                ),
              ]),
        ));
  }
}

class MedicalCenterDetailsTitle extends StatelessWidget {
  MedicalCenterDetailsTitle(this._title);
  final String _title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Text(
        this._title,
        style: TextStyle(
            color: kAguaMarina, fontSize: 22, fontFamily: 'PoppinsBold'),
      ),
    );
  }
}

class MedicalCenterDetailsInfo extends StatelessWidget {
  MedicalCenterDetailsInfo(this._info);
  final String _info;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Text(this._info,
          style: TextStyle(
            color: kLetras,
            fontSize: 18,
            fontFamily: 'PoppinsRegular',
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.dotted,
          )),
    );
  }
}
