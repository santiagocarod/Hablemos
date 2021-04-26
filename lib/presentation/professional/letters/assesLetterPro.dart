import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/carta.dart';
import 'package:hablemos/presentation/professional/letters/showLetterPro.dart';

class AssesLetterPro extends StatelessWidget {
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Carta carta = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: appBarCarta("Valorar Carta", null, 0, null),
        body: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/lettersBackground.png',
              alignment: Alignment.center,
              fit: BoxFit.fill,
              width: size.width,
              height: size.height,
            ),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                          onTap: () {},
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
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
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
    );
  }
}
