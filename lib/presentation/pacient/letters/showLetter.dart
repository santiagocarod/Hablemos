import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/model/carta.dart';

/// Clase que muestra la información de una [Carta] en especifico.
///
/// Recibe una [Carta] cómo parámetro y despliega su información
class ShowLetter extends StatelessWidget {
  final Carta carta = Carta();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Carta carta = ModalRoute.of(context).settings.arguments;
    return Stack(
      children: [
        Container(
          child: Image.asset(
            'assets/images/background_cartas.png',
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
              appBar: crearAppBar("Carta", null, 0, null, context: context),
              body: Stack(children: <Widget>[
                Material(
                  type: MaterialType.transparency,
                  child: Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                              child: Text(
                                "${carta.titulo[0].toUpperCase()}${carta.titulo.substring(1)}",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    fontFamily: "PoppinSemiBold", fontSize: 24),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                            child: Text(
                              carta.cuerpo,
                              textAlign: TextAlign.justify,
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
                )
              ])),
        ),
      ],
    );
  }
}
