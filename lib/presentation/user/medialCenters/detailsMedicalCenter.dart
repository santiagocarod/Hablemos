import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/ux/EncabezadoMedical.dart';
import 'package:hablemos/model/centro_atencion.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';

class DetailsMedicalCenter extends StatelessWidget {
  final double _horizontalPadding = 25.0;
  @override
  Widget build(BuildContext context) {
    final CentroAtencion _centroAtencion =
        ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    return Container(
      color: kRosado,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: crearAppBar("", null, 0, null, context: context),
            body: SingleChildScrollView(
              child: Container(
                width: 330.5,
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
                      medicalCenterLocation(context, _centroAtencion),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              width: (size.width / 2) - 20,
                              child:
                                  MedicalCenterDetailsTitleDep("Departamento")),
                          Container(
                              width: (size.width / 2) - 20,
                              child: MedicalCenterDetailsTitle("Ciudad")),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              width: (size.width / 2) - 20,
                              child: MedicalCenterDetailsInfo(
                                  _centroAtencion.departamento)),
                          Container(
                              width: (size.width / 2) - 20,
                              child: Row(
                                children: [
                                  MedicalCenterDetailsInfo(
                                      _centroAtencion.ciudad),
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
                      medicalCenterDetailsEmail(_centroAtencion.correo),
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
                      medicalCenterDetailsTel(_centroAtencion.telefono),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: _horizontalPadding),
                        child: Container(
                          height: 1.0,
                          color: kGrisN,
                        ),
                      ),
                    ]),
              ),
            )),
      ),
    );
  }

  Widget medicalCenterDetailsTel(String info) {
    List<String> phones = info.split("-");
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: phonesToGesture(phones),
      ),
    );
  }

  Widget medicalCenterDetailsEmail(String info) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: GestureDetector(
        onTap: () => launch("mailto://$info"),
        child: Text(info,
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: kAzulOscuro,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: 'PoppinsRegular',
            )),
      ),
    );
  }

  Widget medicalCenterLocation(
      BuildContext context, CentroAtencion _centroAtencion) {
    if (_centroAtencion.ubicacion.toLowerCase() == "sin direccion" ||
        _centroAtencion.ubicacion.toLowerCase() == "sin dirección" ||
        _centroAtencion.ubicacion.toLowerCase() == "no aplica" ||
        _centroAtencion.ubicacion.toLowerCase() == "n/a") {
      return Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Text(_centroAtencion.ubicacion,
            style: TextStyle(
              decoration: TextDecoration.none,
              color: kLetras,
              fontSize: 17,
              fontFamily: 'PoppinsRegular',
            )),
      );
    } else {
      return GestureDetector(
        onTap: () {
          if (kIsWeb) {
            Navigator.pushNamed(context, 'Mapa');
          } else {
            MapsLauncher.launchQuery(_centroAtencion.ubicacion);
            Navigator.pushNamed(context, 'Mapa');
          }
        },
        child: Padding(
          padding: EdgeInsets.only(right: _horizontalPadding),
          child: medicalCenterDetailsMap(_centroAtencion.ubicacion),
        ),
      );
    }
  }

  Widget medicalCenterDetailsMap(String info) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: FittedBox(
        child: Text(info,
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: kAzulOscuro,
              fontSize: 18,
              fontFamily: 'PoppinsRegular',
            )),
      ),
    );
  }

  List<Widget> phonesToGesture(List<String> phones) {
    List<Widget> gestures = [];
    phones.forEach((element) {
      GestureDetector ge = GestureDetector(
        onTap: () => launch("tel://$element"),
        child: Text(element,
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
              color: kAzulOscuro,
              fontSize: 18,
              fontFamily: 'PoppinsRegular',
            )),
      );
      gestures.add(ge);
    });

    return gestures;
  }
}

class MedicalCenterDetailsTitleDep extends StatelessWidget {
  MedicalCenterDetailsTitleDep(this._title);
  final String _title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: FittedBox(
        child: Text(
          this._title,
          style: TextStyle(
              color: kAguaMarina, fontSize: 20.0, fontFamily: 'PoppinsRegular'),
        ),
      ),
    );
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
            color: kAguaMarina, fontSize: 20.0, fontFamily: 'PoppinsRegular'),
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
      child: RichText(
          text: TextSpan(
              text: this._info,
              style: TextStyle(
                color: kLetras,
                fontSize: 17,
                fontFamily: 'PoppinsRegular',
              ))),
    );
  }
}
