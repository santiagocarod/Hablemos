import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/model/grupo.dart';
import 'package:hablemos/ux/atoms.dart';

import '../../../constants.dart';

class SubscribedGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Grupo grupo = ModalRoute.of(context).settings.arguments;
    return eventoSubcripto(context, size, grupo);
  }

  Widget eventoSubcripto(BuildContext context, Size size, Grupo grupo) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBar(grupo.titulo, null, 0, null),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height * 0.155,
            ),
            Center(
              child: Container(
                width: 272.0,
                height: 196.0,
                decoration: BoxDecoration(
                  image: grupo.foto,
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
                          "${grupo.descripcion}",
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
                                "${grupo.fecha}",
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
                                "${grupo.hora}",
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
                Container(
                  width: 330.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Correo",
                          style: TextStyle(
                              fontFamily: "PoppinsRegular",
                              color: kMoradoOscuro,
                              fontSize: 20.0),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "lapapaya@gmail.com",
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
                _seccionUbicacion(grupo),
                SizedBox(height: size.height * 0.03),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          if (grupo.valor.toLowerCase() == "sin costo") {
                            return dialogoConfirmacion(
                              context,
                              size,
                              grupo,
                              "Confirmación de Cancelación",
                              "¿Estás seguro que deseas cancelar la inscripción a este Grupo de Apoyo?",
                              kMoradoClarito,
                            );
                          } else if (grupo.ubicacion.toLowerCase() ==
                              "virtual") {
                            return dialogoConfirmacionConPago(
                              context,
                              size,
                              grupo,
                              "Confirmación de Cancelación",
                              "¡Recuerda que debes comunicarte con La Papaya para la devolución de tu dinero si ya realizaste el pago!",
                              kMoradoClarito,
                            );
                          } else {
                            return dialogoConfirmacion(
                              context,
                              size,
                              grupo,
                              "Confirmación de Cancelación",
                              "¿Estás seguro que deseas cancelar la inscripción a este Grupo de Apoyo?",
                              kMoradoClarito,
                            );
                          }
                        });
                  },
                  child: Container(
                    width: 310.0,
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
                        "CANCELAR INSCRIPCIÓN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kNegro,
                          fontSize: 19.0,
                          fontFamily: 'PoppinSemiBold',
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _seccionUbicacion(Grupo grupo) {
    if (grupo.ubicacion.toLowerCase() == "virtual") {
      return Container(
        width: 330.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Ubicación",
                style: TextStyle(
                    fontFamily: "PoppinsRegular",
                    color: kMoradoOscuro,
                    fontSize: 20.0),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "El link llegará a su correo personal",
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
    }
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
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "${grupo.ubicacion}",
                  style: TextStyle(
                      fontFamily: "PoppinsRegular",
                      color: kLetras,
                      fontSize: 17.0),
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

  AlertDialog dialogoConfirmacion(BuildContext context, Size size, Grupo grupo,
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
                          Navigator.pushNamed(context, 'verGrupoApoyo',
                              arguments: grupo);
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

  AlertDialog dialogoConfirmacionConPago(BuildContext context, Size size,
      Grupo grupo, String titulo, String pregunta, Color color) {
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
              height: 80.0,
              child: Text(
                "$pregunta",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    color: kNegro, fontSize: 15, fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'verGrupo', arguments: grupo);
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
                    child: Text("Ok",
                        style: GoogleFonts.montserrat(
                            color: kNegro,
                            fontSize: 14,
                            fontWeight: FontWeight.w300)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
