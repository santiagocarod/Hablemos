import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/model/carta.dart';
import 'package:hablemos/util/snapshotConvertes.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/ux/loading_screen.dart';

/// Clase encargada de mostrar las [Carta] que no han sido aprobadas al profesional.
///
/// En caso de hacer click sobre alguna de las cartas redirecciona a [AssesLetterPro()] para que el profesional pueda valorar la carta.
class ListToEvaluateLettersPro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CollectionReference cartasCollection =
        FirebaseFirestore.instance.collection("letters");
    return StreamBuilder<QuerySnapshot>(
        stream: cartasCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('ALGO SALIO MAL');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingScreen();
          }
          List<Carta> cartas = cartaMapToList(snapshot, false);
          return Stack(
            children: [
              //Background Image
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
                  appBar: crearAppBarEventos(context, 'Cartas a Valorar',
                      'cartasPrincipalProfesional'),
                  body: Stack(
                    children: <Widget>[
                      // Contents
                      Material(
                        type: MaterialType.transparency,
                        child: Padding(
                          padding: EdgeInsets.only(top: 80.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: letterToCard(context, size, cartas,
                                  "valorarCartaPro", false),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
