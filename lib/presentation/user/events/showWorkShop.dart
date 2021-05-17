import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/business/admin/negocioEventos.dart';
import 'package:hablemos/model/participante.dart';
import 'package:hablemos/model/taller.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../../constants.dart';

class ShowWorkShop extends StatefulWidget {
  @override
  _ShowWorkShopState createState() => _ShowWorkShopState();
}

class _ShowWorkShopState extends State<ShowWorkShop> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController searchController = TextEditingController();

  String rol = "pacient";

  Participante participante;

  String uid;

  @override
  void initState() {
    super.initState();

    if (auth.currentUser != null) {
      User user = auth.currentUser;

      uid = user.uid;

      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          setState(() {
            print("OJOOOOOOOOOOOOOOO");
            print(uid);
            print(documentSnapshot.get("role"));
            rol = documentSnapshot.get("role");
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Taller taller = ModalRoute.of(context).settings.arguments;
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    if (firebaseAuth.currentUser != null) {
      if (rol == "pacient") {
        FirebaseFirestore.instance
            .collection("pacients")
            .doc(uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          participante = Participante(
            nombre: documentSnapshot.get("name"),
            apellido: documentSnapshot.get("lastName"),
            correo: documentSnapshot.get("email"),
            telefono: documentSnapshot.get("phone"),
            uid: documentSnapshot.get("uid"),
          );
        });
      }

      if (rol == "professional") {
        FirebaseFirestore.instance
            .collection("professionals")
            .doc(uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          participante = Participante(
            nombre: documentSnapshot.get("name"),
            apellido: documentSnapshot.get("lastName"),
            correo: documentSnapshot.get("email"),
            telefono: documentSnapshot.get("phone"),
            uid: documentSnapshot.get("uid"),
          );
        });
      }
    }

    FirebaseFirestore.instance
        .collection("workshops")
        .doc(taller.id)
        .get()
        .then((value) {
      Map<String, dynamic> map = value.data();

      if (map["participants"] != null) {
        List<dynamic> list = map["participants"];
        list.forEach((element) {
          Map<String, dynamic> map2 = element;
          if (map2["uid"] != null && map2["uid"] == auth.currentUser.uid) {
            Navigator.pushReplacementNamed(context, 'tallerSubscripto',
                arguments: taller);
          }
        });
      }
    });

    return Container(
      color: kBlanco,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: crearAppBarEventos(context, taller.titulo, "listarTalleres"),
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
                      image: DecorationImage(image: NetworkImage(taller.foto)),
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
                              "${taller.descripcion}",
                              textAlign: TextAlign.justify,
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
                    _seccionUbicacion(context, taller),
                    Container(
                      width: 330.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 150.5,
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
                                    "${taller.valor}",
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
                            width: 150.5,
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Sesiones",
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
                                    "${taller.numeroSesiones}",
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
                    ),
                    SizedBox(height: 10),
                    _seccionFinanciera(context, taller),
                    SizedBox(height: size.height * 0.03),
                    _inscripcion(context, taller, size),
                    SizedBox(
                      height: 30.0,
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

  Widget _seccionFinanciera(BuildContext context, Taller taller) {
    if (taller.valor.toLowerCase() == "sin costo" ||
        taller.valor.toLowerCase() == "gratis" ||
        taller.valor.toLowerCase() == "gratuito" ||
        taller.valor.toLowerCase() == "0" ||
        taller.valor.toLowerCase() == "") {
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
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Información de Pago",
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
                          fit: BoxFit.contain,
                          child: Text(
                            "${taller.banco.toString()}",
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
            ),
          ],
        ),
      );
    }
  }

  Widget _seccionUbicacion(BuildContext context, Taller taller) {
    if (taller.ubicacion.toLowerCase() == "virtual") {
      return Column(
        children: [
          Container(
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
                        "${taller.ubicacion}",
                        style: TextStyle(
                            fontFamily: "PoppinsRegular",
                            color: kLetras,
                            fontSize: 17.0),
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
          ),
        ],
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
            GestureDetector(
              onTap: () {
                if (kIsWeb) {
                  Navigator.pushNamed(context, 'Mapa');
                } else {
                  MapsLauncher.launchQuery(taller.ubicacion);
                  Navigator.pushNamed(context, 'Mapa');
                }
              },
              child: Row(
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
                  Icon(Icons.location_on, size: 26.0)
                ],
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
  }

  AlertDialog dialogoConfirmacion(BuildContext context, Size size,
      Taller taller, String titulo, String pregunta, Color color) {
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
                          if (agregarParticipante(participante, taller)) {
                            showDialog(
                                context: context,
                                builder: (BuildContext contex) =>
                                    _buildPopupDialog(context, "¡Exito!",
                                        "¡Inscripción Correcta!", taller,
                                        ruta: "tallerSubscripto"));
                          }
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

  AlertDialog dialogoConfirmacionPago(BuildContext context, Taller taller,
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
                      Map<String, dynamic> aux =
                          ({"taller": taller, "participante": participante});

                      Navigator.pushNamed(context, "adjuntarPagoTaller",
                          arguments: aux);
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
        ),
      ),
    );
  }

  Widget _inscripcion(BuildContext context, Taller taller, Size size) {
    if (auth.currentUser != null) {
      return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                if (taller.valor.toLowerCase() == "sin costo" ||
                    taller.valor.toLowerCase() == "gratis" ||
                    taller.valor.toLowerCase() == "gratuito" ||
                    taller.valor.toLowerCase() == "0" ||
                    taller.valor.toLowerCase() == "") {
                  return dialogoConfirmacion(
                    context,
                    size,
                    taller,
                    "Confirmación de Inscripción",
                    "¿Estás seguro que deseas inscribirte en este taller?",
                    kMoradoClarito,
                  );
                } else if (taller.ubicacion.toLowerCase() == "virtual") {
                  return dialogoConfirmacionPago(
                    context,
                    taller,
                    "Confirmación de Pago",
                    "¿Ya realizaste el pago al número de cuenta?",
                    kMoradoClarito,
                  );
                } else {
                  return dialogoConfirmacion(
                    context,
                    size,
                    taller,
                    "Confirmación de Inscripción",
                    "¿Estás seguro que deseas inscribirte en este taller?",
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
    } else
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'registro');
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0),
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(228, 88, 101, 0.5),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          height: 80.0,
          child: Center(
            child: Text(
              "Para Inscribirse a este Taller debe Registarse",
              style: TextStyle(
                color: kLetras,
                fontSize: 17.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
  }
}

Widget _buildPopupDialog(
    BuildContext context, String tittle, String content, Taller taller,
    {String ruta}) {
  return new AlertDialog(
    title: Text(tittle),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(content),
      ],
    ),
    actions: <Widget>[
      new ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
          if (ruta != null) {
            Navigator.pushNamed(context, ruta, arguments: taller);
          }
        },
        style: ElevatedButton.styleFrom(
          primary: kRojoOscuro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(378.0),
          ),
          shadowColor: Colors.black,
        ),
        child: const Text('Cerrar'),
      ),
    ],
  );
}
