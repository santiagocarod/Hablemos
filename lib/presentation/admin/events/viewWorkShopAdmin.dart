import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/model/taller.dart';
import 'package:hablemos/ux/atoms.dart';

import '../../../constants.dart';

class ViewWorkShopAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Taller taller = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: crearAppBarEventos(
            context, "${taller.titulo}", "eventosAdministrador"),
        body: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/eventsAdminBackground.png',
              alignment: Alignment.center,
              fit: BoxFit.fill,
              width: size.width,
              height: size.height,
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.15,
                  ),
                  Center(
                    child: Container(
                      width: 315.0,
                      height: 137.0,
                      decoration: BoxDecoration(
                        image: taller.foto,
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
                    height: size.height * 0.05,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        width: 330.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Descripción",
                                    style: TextStyle(
                                        fontFamily: "PoppinsRegular",
                                        color: kMostazaOscuro,
                                        fontSize: 18.0),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.assignment_ind),
                                      SizedBox(width: 10.0),
                                      Text(
                                        "Ver Inscritos",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 7.0,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "${taller.descripcion}",
                                style: TextStyle(
                                    fontFamily: "PoppinsRegular",
                                    color: kLetras,
                                    fontSize: 17.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              child: Container(
                                height: 1.0,
                                color: kGrisN,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
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
                                    color: kMostazaOscuro,
                                    fontSize: 18.0),
                              ),
                            ),
                            SizedBox(height: 7.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "${taller.ubicacion}",
                                    style: TextStyle(
                                        fontFamily: "PoppinsRegular",
                                        color: kLetras,
                                        fontSize: 17.0),
                                  ),
                                ),
                                Icon(
                                  Icons.location_on,
                                )
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
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Horario",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontFamily: "PoppinsRegular",
                                    color: kMostazaOscuro,
                                    fontSize: 18.0),
                              ),
                            ),
                            SizedBox(
                              height: 7.0,
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
                                      "${taller.fecha}",
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
                                      "${taller.hora}",
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
                              padding: EdgeInsets.symmetric(vertical: 12.0),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 145.5,
                              child: Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Sesiones",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontFamily: "PoppinsRegular",
                                          color: kMostazaOscuro,
                                          fontSize: 18.0),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "${taller.numeroSesiones}",
                                      style: TextStyle(
                                          fontFamily: "PoppinsRegular",
                                          color: kLetras,
                                          fontSize: 17.0),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: Container(
                                      height: 1.0,
                                      color: kGrisN,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 145.5,
                              child: Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Precio",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontFamily: "PoppinsRegular",
                                          color: kMostazaOscuro,
                                          fontSize: 18.0),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "${taller.valor}",
                                      style: TextStyle(
                                          fontFamily: "PoppinsRegular",
                                          color: kLetras,
                                          fontSize: 17.0),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.0),
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
                      ),
                      SizedBox(height: 10),
                      _datosFinancieros(context, taller),
                      SizedBox(height: size.height * 0.03),
                      Container(
                        width: 330.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.add_circle_outline),
                                  SizedBox(width: 10.0),
                                  Text(
                                    "Modificar",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.remove_circle_outline),
                                  SizedBox(width: 10.0),
                                  Text(
                                    "Eliminar",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
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
          ],
        ));
  }

  Widget _datosFinancieros(BuildContext context, Taller taller) {
    if (taller.ubicacion.toLowerCase() != "virtual") {
      return SizedBox(height: 5.0);
    } else {
      return Container(
        width: 330.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 133.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Banco",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "PoppinsRegular",
                          color: kMostazaOscuro,
                          fontSize: 18.0),
                    ),
                  ),
                  FittedBox(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "${taller.banco}",
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
            Container(
              width: 183.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Número de Cuenta",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "PoppinsRegular",
                          color: kMostazaOscuro,
                          fontSize: 18.0),
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      "${taller.numCuenta}",
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
}
