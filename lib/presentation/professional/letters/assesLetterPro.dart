import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hablemos/business/professional/negocioCartasPro.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/carta.dart';
import 'package:hablemos/ux/atoms.dart';

class AssesLetterPro extends StatelessWidget {
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Carta carta = ModalRoute.of(context).settings.arguments;
    return Stack(
      children: [
        Container(
          child: Image.asset(
            'assets/images/lettersBackground.png',
            alignment: Alignment.center,
            fit: BoxFit.fill,
            width: size.width,
            height: size.height,
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: crearAppBarEventos(
                context, 'Valorar Carta', 'listaCartasEvaluar'),
            body: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: size.height * 0.15),
                          width: size.width * 0.85,
                          decoration: BoxDecoration(
                            color: kBlanco,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 10.0,
                                  color: Colors.grey.withOpacity(0.5)),
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              Material(
                                type: MaterialType.transparency,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text(
                                            carta.titulo,
                                            style: TextStyle(
                                                fontFamily: "PoppinSemiBold",
                                                fontSize: 18),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 25, 20, 20),
                                          child: Text(
                                            carta.cuerpo,
                                            style: TextStyle(
                                                fontFamily: "PoppinsRegular",
                                                fontSize: 14,
                                                color: kLetras),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: size.width * 0.15, bottom: size.width * 0.05),
                        height: 54.0,
                        width: size.width * 0.90,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        _buildDialogAcept(
                                            context, carta, size));
                              },
                              child: Container(
                                width: 155.0,
                                decoration: BoxDecoration(
                                  color: kAzulOscuro,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 0),
                                        blurRadius: 5,
                                        color: Colors.grey.withOpacity(0.5)),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    "Aceptar",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: kBlanco,
                                      fontSize: 15.0,
                                      fontFamily: 'PoppinsSemiBold',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "editarCartaPro",
                                    arguments: carta);
                              },
                              child: Container(
                                width: 155.0,
                                decoration: BoxDecoration(
                                  color: kAzulOscuro,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 0),
                                        blurRadius: 5,
                                        color: Colors.grey.withOpacity(0.5)),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    "Editar",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: kBlanco,
                                      fontSize: 15.0,
                                      fontFamily: 'PoppinsSemiBold',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildDialogReject(context, carta, size),
                          );
                        },
                        child: Container(
                          width: 155.0,
                          height: 54.0,
                          decoration: BoxDecoration(
                            color: kAzulOscuro,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 5,
                                  color: Colors.grey.withOpacity(0.5)),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "Rechazar",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kBlanco,
                                fontSize: 15.0,
                                fontFamily: 'PoppinsSemiBold',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Dialogo de Confirmación de Rechazo de Carta para su publicación.
  Widget _buildDialogReject(BuildContext context, Carta carta, Size size) {
    String title2 = "";
    String content2 = "";
    return new AlertDialog(
      title: Text(
        'Confirmación Rechazo de Carta',
        style: TextStyle(
          color: kNegro,
          fontSize: 15.0,
          fontFamily: 'PoppinsRegular',
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        '¿Estás seguro que deseas rechazar y eliminar esta carta?',
        style: TextStyle(
          color: kNegro,
          fontSize: 14.0,
          fontFamily: 'PoppinsRegular',
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(37.0),
        side: BorderSide(color: kNegro, width: 2.0),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  eliminarCarta(carta).then((value) {
                    bool state;
                    if (value) {
                      title2 = 'Carta eliminada';
                      content2 = "La carta fue eliminada exitosamente";
                      state = true;
                    } else {
                      title2 = 'Error de eliminación';
                      content2 =
                          "Hubo un error eliminando la carta, inténtelo nuevamente";
                      state = false;
                    }
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => adviceDialogLetter(
                              context,
                              title2,
                              content2,
                              state,
                            ));
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(99.0, 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0),
                    side: BorderSide(color: kNegro),
                  ),
                  shadowColor: Colors.black,
                ),
                child: const Text(
                  'Si',
                  style: TextStyle(
                    color: kNegro,
                    fontSize: 14.0,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.065,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(99.0, 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0),
                    side: BorderSide(color: kNegro),
                  ),
                  shadowColor: Colors.black,
                ),
                child: const Text(
                  'No',
                  style: TextStyle(
                    color: kNegro,
                    fontSize: 14.0,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Dialogo Aceptación de Carta para su publicación.
  Widget _buildDialogAcept(BuildContext context, Carta carta, Size size) {
    String title2 = "";
    String content2 = "";
    return new AlertDialog(
      title: Text(
        'Confirmación Aceptación de Carta',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kNegro,
          fontSize: 15.0,
          fontFamily: 'PoppinsRegular',
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        '¿Estás seguro que deseas aceptar y publicar esta carta?',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kNegro,
          fontSize: 14.0,
          fontFamily: 'PoppinsRegular',
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(37.0),
        side: BorderSide(color: kNegro, width: 2.0),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  aceptarCarta(carta).then((value) {
                    bool state;
                    if (value) {
                      title2 = '¡Carta Aceptada!';
                      content2 =
                          "¡La carta fue aceptada y publicada exitosamente!";
                      state = true;
                    } else {
                      title2 = 'Error de Aceptación';
                      content2 =
                          "Hubo un error aceptando la carta, inténtalo nuevamente.";
                      state = false;
                    }
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => adviceDialogLetter(
                              context,
                              title2,
                              content2,
                              state,
                            ));
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(99.0, 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0),
                    side: BorderSide(color: kNegro),
                  ),
                  shadowColor: Colors.black,
                ),
                child: const Text(
                  'Si',
                  style: TextStyle(
                    color: kNegro,
                    fontSize: 14.0,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.065,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(99.0, 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0),
                    side: BorderSide(color: kNegro),
                  ),
                  shadowColor: Colors.black,
                ),
                child: const Text(
                  'No',
                  style: TextStyle(
                    color: kNegro,
                    fontSize: 14.0,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
