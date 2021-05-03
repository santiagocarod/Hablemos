import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/actividad.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ShowActivity extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Actividad actividad = ModalRoute.of(context).settings.arguments;
    return Container(
      color: kBlanco,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: crearAppBarEventos(
              context, actividad.titulo, "listarActividades"),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.15,
                ),
                Center(
                  child: Container(
                    width: 272.0,
                    height: 196.0,
                    decoration: BoxDecoration(
                      image: actividad.foto,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 7.0,
                            color: Colors.grey.withOpacity(0.5)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Column(
                  children: <Widget>[
                    Container(
                      width: 330.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Descripción",
                              style: TextStyle(
                                  fontFamily: "PoppinsRegular",
                                  color: kMoradoOscuro,
                                  fontSize: 20.0),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${actividad.descripcion}",
                              style: TextStyle(
                                  fontFamily: "PoppinsRegular",
                                  color: kLetras,
                                  fontSize: 17.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Container(
                              height: 1.0,
                              color: kGrisN,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 330.5,
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Horario",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontFamily: "PoppinsRegular",
                                  color: kMoradoOscuro,
                                  fontSize: 20.0),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Row(children: <Widget>[
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    color: kNegro,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${actividad.fecha}",
                                    style: TextStyle(
                                        fontFamily: "PoppinsRegular",
                                        color: kLetras,
                                        fontSize: 17.0),
                                  ),
                                ]),
                              ),
                              Container(
                                child: Row(children: <Widget>[
                                  Icon(
                                    Icons.access_time_outlined,
                                    color: kNegro,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${actividad.hora}",
                                    style: TextStyle(
                                        fontFamily: "PoppinsRegular",
                                        color: kLetras,
                                        fontSize: 17.0),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Container(
                              height: 1.0,
                              color: kGrisN,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    _sectionCosto(context, actividad),
                    SizedBox(height: 10),
                    _sectionAccountNum(context, actividad),
                    SizedBox(height: size.height * 0.03),
                    _inscripcion(context, actividad),
                    SizedBox(
                      height: 40.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _seccionUbicacion(BuildContext context, Actividad actividad) {
    if (actividad.ubicacion.toLowerCase() == "virtual") {
      return Container(
        width: 133.5,
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Ubicación",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: "PoppinsRegular",
                    color: kMoradoOscuro,
                    fontSize: 20.0),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      "${actividad.ubicacion}",
                      style: TextStyle(
                          fontFamily: "PoppinsRegular",
                          color: kLetras,
                          fontSize: 17.0),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                height: 1.0,
                color: kGrisN,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: 330.5,
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Ubicación",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: "PoppinsRegular",
                    color: kMoradoOscuro,
                    fontSize: 20.0),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    if (kIsWeb) {
                      Navigator.pushNamed(context, 'Mapa');
                    } else {
                      MapsLauncher.launchQuery(actividad.ubicacion);
                      Navigator.pushNamed(context, 'Mapa');
                    }
                  },
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${actividad.ubicacion}",
                      style: TextStyle(
                          fontFamily: "PoppinsRegular",
                          color: kLetras,
                          fontSize: 17.0),
                    ),
                  ),
                ),
                Icon(Icons.location_on, size: 26.0)
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                height: 1.0,
                color: kGrisN,
              ),
            ),
          ],
        ),
      );
    }
  }

  AlertDialog dialogoConfirmacion(BuildContext context, Actividad actividad,
      String titulo, String pregunta, Color color) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(37.0))),
        backgroundColor: color,
        content: Container(
            height: 170.0,
            width: 302.0,
            child: Column(
              children: <Widget>[
                Text(
                  "$titulo",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold, fontSize: 16, color: kNegro),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  width: 259.0,
                  height: 55.0,
                  child: Text(
                    "$pregunta",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        color: kNegro,
                        fontSize: 15,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "actividadSubscripto",
                              arguments: actividad);
                        },
                        child: Container(
                          height: 30,
                          width: 99,
                          decoration: BoxDecoration(
                            color: kBlanco,
                            borderRadius: BorderRadius.all(
                              Radius.circular(22.0),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Si",
                                style: GoogleFonts.montserrat(
                                    color: kNegro,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300)),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 30,
                          width: 99,
                          decoration: BoxDecoration(
                            color: kBlanco,
                            borderRadius: BorderRadius.all(
                              Radius.circular(22.0),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("No",
                                style: GoogleFonts.montserrat(
                                    color: kNegro,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }

  AlertDialog dialogoConfirmacionPago(BuildContext context, Actividad actividad,
      String titulo, String pregunta, Color color) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(37.0))),
        backgroundColor: color,
        content: Container(
            height: 170.0,
            width: 302.0,
            child: Column(
              children: <Widget>[
                Text(
                  "$titulo",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold, fontSize: 16, color: kNegro),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  width: 259.0,
                  height: 55.0,
                  child: Text(
                    "$pregunta",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        color: kNegro,
                        fontSize: 15,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "adjuntarPagoActividad",
                              arguments: actividad);
                        },
                        child: Container(
                          height: 30,
                          width: 99,
                          decoration: BoxDecoration(
                            color: kBlanco,
                            borderRadius: BorderRadius.all(
                              Radius.circular(22.0),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Si",
                                style: GoogleFonts.montserrat(
                                    color: kNegro,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300)),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 30,
                          width: 99,
                          decoration: BoxDecoration(
                            color: kBlanco,
                            borderRadius: BorderRadius.all(
                              Radius.circular(22.0),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("No",
                                style: GoogleFonts.montserrat(
                                    color: kNegro,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }

  Widget _sectionAccountNum(BuildContext context, Actividad actividad) {
    if (actividad.valor.toLowerCase() == "sin costo" ||
        actividad.ubicacion.toLowerCase() != "virtual") {
      return Container(
        alignment: Alignment.centerLeft,
        width: 330.5,
        child: _seccionUbicacion(context, actividad),
      );
    } else {
      return Container(
        width: 330.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _seccionUbicacion(context, actividad),
            Container(
              width: 183.0,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: FittedBox(
                      child: Text(
                        "Número de Cuenta",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontFamily: "PoppinsRegular",
                            color: kMoradoOscuro,
                            fontSize: 20.0),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: FittedBox(
                      child: Text(
                        "${actividad.banco.numCuenta}",
                        style: TextStyle(
                            fontFamily: "PoppinsRegular",
                            color: kLetras,
                            fontSize: 17.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      height: 1.0,
                      color: kGrisN,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _sectionCosto(BuildContext context, Actividad actividad) {
    if (actividad.valor.toLowerCase() == "sin costo" ||
        actividad.ubicacion.toLowerCase() != "virtual") {
      return Container(
        width: 330.5,
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Costo",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: "PoppinsRegular",
                    color: kMoradoOscuro,
                    fontSize: 20.0),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "${actividad.valor}",
                style: TextStyle(
                    fontFamily: "PoppinsRegular",
                    color: kLetras,
                    fontSize: 17.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                height: 1.0,
                color: kGrisN,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: 330.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 133.5,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Costo",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "PoppinsRegular",
                          color: kMoradoOscuro,
                          fontSize: 20.0),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${actividad.valor}",
                      style: TextStyle(
                          fontFamily: "PoppinsRegular",
                          color: kLetras,
                          fontSize: 17.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      height: 1.0,
                      color: kGrisN,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 183.0,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Banco",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "PoppinsRegular",
                          color: kMoradoOscuro,
                          fontSize: 20.0),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${actividad.banco.banco}",
                      style: TextStyle(
                          fontFamily: "PoppinsRegular",
                          color: kLetras,
                          fontSize: 17.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      height: 1.0,
                      color: kGrisN,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _inscripcion(BuildContext context, Actividad actividad) {
    if (auth.currentUser != null) {
      return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                if (actividad.valor.toLowerCase() == "sin costo") {
                  return dialogoConfirmacion(
                    context,
                    actividad,
                    "Confirmación de Inscripción",
                    "¿Estás seguro que deseas inscribirte en esta Actividad?",
                    kMoradoClarito,
                  );
                } else if (actividad.ubicacion == "virtual" ||
                    actividad.ubicacion == "Virtual") {
                  return dialogoConfirmacionPago(
                    context,
                    actividad,
                    "Confirmación de Pago",
                    "¿Ya realizaste el pago al número de cuenta?",
                    kMoradoClarito,
                  );
                } else {
                  return dialogoConfirmacion(
                    context,
                    actividad,
                    "Confirmación de Inscripción",
                    "¿Estás seguro que deseas inscribirte en esta Actividad?",
                    kMoradoClarito,
                  );
                }
              });
        },
        child: Container(
          width: 296.0,
          height: 55.0,
          decoration: BoxDecoration(
            color: kMoradoClarito,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 7.0,
                  color: Colors.grey.withOpacity(0.5)),
            ],
          ),
          child: Center(
            child: Text(
              "INSCRIBIRME",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kNegro,
                fontSize: 20.0,
                fontFamily: 'PoppinSemiBold',
                letterSpacing: 2.0,
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 30.0),
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(228, 88, 101, 0.5),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        height: 80.0,
        child: Center(
          child: Text(
            "Para Inscribirse a esta Actividad debe Registarse",
            style: TextStyle(
              color: kLetras,
              fontSize: 17.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }
}
