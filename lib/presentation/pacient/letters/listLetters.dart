import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/model/carta.dart';
import 'package:hablemos/util/snapshotConvertes.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/ux/loading_screen.dart';
import 'dart:math';

import '../../../ux/atoms.dart';

///Clase encargada de hacer la petición de [Carta] a firebase
///
///Solo va a desplegar las cartas que esten aprobadas [Carta.aprobado] == `true`
///Cuando se hace click sobre una carta se muestra la carta completa en [ShowLetter()]
///En la esquina superior derecha hay un botón de aleatorio.
///Despliega una [Carta] aleatoria en [ShowLetter()]s
class ListLetters extends StatelessWidget {
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
          List<Carta> cartas = cartaMapToList(snapshot, true);
          return Stack(
            children: [
              Container(
                child: //Background Image
                    Image.asset(
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
                  appBar: crearAppBarCitas(
                      context, "inicio", "Cartas", null, 0, null, Icons.shuffle,
                      () {
                    Navigator.pushNamed(context, "verCarta",
                        arguments: cartas[Random().nextInt(cartas.length)]);
                  }),
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
                              children: letterToCard(
                                  context, size, cartas, "verCarta", true),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: kMostaza,
                    child: Icon(Icons.add),
                    onPressed: () {
                      Navigator.pushNamed(context, "agregarCarta");
                    },
                  ),
                ),
              ),
            ],
          );
        });
  }
}
