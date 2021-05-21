import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';

/// Clase encargada dele menú principal de las Cartas para el profesional
///
/// Aqui el profesional puede escoger entre ver las cartas aceptadas o las cartas pendientes por aceptar.
class MainLettersPro extends StatelessWidget {
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: size.height * 0.07,
                  ),
                  alignment: Alignment.center,
                  width: size.width,
                  child: Column(children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _pageHeaderAction(
                            context, size, "Cartas", "inicioProfesional"),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _contenedor(context, size, "Leer Cartas",
                                "listarCartasPro"),
                            _contenedor(context, size, "Valorar Cartas",
                                "listaCartasEvaluar")
                          ],
                        )
                      ],
                    )
                  ]),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Contenedor general para el botón de las cartas.
///
/// [titulo] Pone el titulo del botón
/// [paginaRedireccion] indica hacia donde tiene que redireccionar el botón
Widget _contenedor(
    BuildContext context, Size size, String titulo, String paginaRedireccion) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, paginaRedireccion);
    },
    child: Container(
      height: 150,
      width: 327,
      margin: EdgeInsets.symmetric(vertical: 64),
      alignment: Alignment.center,
      child: Text(
        titulo,
        style: TextStyle(
            color: kLetras,
            fontSize: 22.0,
            fontFamily: 'PoppinsRegular',
            decoration: TextDecoration.none,
            fontStyle: FontStyle.normal),
      ),
      decoration: BoxDecoration(
        color: kBlanco,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 5.0,
              color: Colors.grey.withOpacity(0.5)),
        ],
      ),
    ),
  );
}

/// Cabecera principal de la pantalla
Widget _pageHeaderAction(
    BuildContext context, Size size, String titulo, String ruta) {
  return Container(
    padding: EdgeInsets.only(bottom: size.height * 0.03),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ruta);
          },
          child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: size.width * 0.05),
              child: Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: kNegro,
              )),
        ),
        Container(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              titulo,
              style: TextStyle(
                  color: kLetras,
                  fontSize: 22.0,
                  fontFamily: 'PoppinsRegular',
                  decoration: TextDecoration.none,
                  fontStyle: FontStyle.normal),
            ),
          ),
        ),
        SizedBox(width: size.width * 0.05),
      ],
    ),
  );
}
