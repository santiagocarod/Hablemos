import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/business/admin/negocioEventos.dart';
import 'package:hablemos/model/grupo.dart';
import 'package:hablemos/ux/atoms.dart';

import 'package:maps_launcher/maps_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../../constants.dart';

/// Clase encargada de mostrar la informacion completa de un evento
///
/// En este caso se muestra la información de un [Grupo]
/// El administrador tiene la posibilidad de eliminar o modificar el grupo
class ViewGroupAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Grupo grupo = ModalRoute.of(context).settings.arguments;
    return Container(
      color: kAmarilloClaro,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: crearAppBarEventos(
              context, "${grupo.titulo}", "listarGruposAdmin"),
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
                          image:
                              DecorationImage(image: NetworkImage(grupo.foto)),
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
                      height: size.height * 0.04,
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: 330.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "verListaDeInscritos",
                                          arguments: grupo);
                                    },
                                    child: Container(
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
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 7.0,
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
                                padding: EdgeInsets.symmetric(vertical: 12.0),
                                child: Container(
                                  height: 1.0,
                                  color: kGrisN,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _ubicacion(context, grupo),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        "${grupo.numeroSesiones}",
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
                                        "${grupo.valor}",
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
                        _datosFinancieros(context, grupo),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          width: 330.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return dialogoModificacion(
                                          context,
                                          "modificarGrupo",
                                          "Confirmación de Modificación",
                                          "¿Está seguro que desea modificar este Grupo de Apoyo?",
                                          grupo);
                                    },
                                  );
                                },
                                child: Container(
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
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return dialogoConfirmacion(
                                          context,
                                          "listarGruposAdmin",
                                          "Confirmacion Eliminación",
                                          "¿Esta seguro que quiere eliminar este grupo? ",
                                          eliminarGrupo,
                                          parametro: grupo);
                                    },
                                  );
                                },
                                child: Container(
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
          ),
        ),
      ),
    );
  }

  /// Seccion especifica para la Ubicación del evento
  ///
  /// En caso de no ser virtual se puede abrir el mapa
  Widget _ubicacion(BuildContext context, Grupo grupo) {
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
                    color: kMostazaOscuro,
                    fontSize: 18.0),
              ),
            ),
            SizedBox(height: 7.0),
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
              children: [
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
                GestureDetector(
                  onTap: () {
                    if (kIsWeb) {
                      Navigator.pushNamed(context, 'Mapa');
                    } else {
                      MapsLauncher.launchQuery(grupo.ubicacion);
                      Navigator.pushNamed(context, 'Mapa');
                    }
                  },
                  child: Icon(
                    Icons.location_on,
                  ),
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
      );
    }
  }

  /// Seccion especifica para los datos financieros/bancarios del grupo de apoyo
  ///
  /// En caso de que la información bancaria no exista, es decir [Grupo.banco] = `null` no se desplegarán los campos
  Widget _datosFinancieros(BuildContext context, Grupo grupo) {
    if (grupo.banco == null) {
      return SizedBox(height: 5.0);
    } else {
      return Container(
        width: 330.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 330.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Información Bancaria",
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
                        "${grupo.banco.toString()}",
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

  /// Dialogo que confirmación el deseo del administrador para modificar contenido del grupo de apoyo
  ///
  /// Redirige al administrador a la pantalla de modificación e invoca el metodo [ModifyGroup()]
  AlertDialog dialogoModificacion(BuildContext context, String rutaSi,
      String titulo, String mensaje, Grupo grupo) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: kNegro, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(37.0))),
      backgroundColor: kBlanco,
      content: Container(
        height: 170.0,
        width: 302.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                "$mensaje",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    color: kNegro, fontSize: 15, fontWeight: FontWeight.w300),
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
                      Navigator.pushNamed(context, rutaSi, arguments: grupo);
                    },
                    child: Container(
                      height: 30,
                      width: 99,
                      decoration: BoxDecoration(
                        border: Border.all(color: kNegro),
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
                        border: Border.all(color: kNegro),
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
        ),
      ),
    );
  }
}
