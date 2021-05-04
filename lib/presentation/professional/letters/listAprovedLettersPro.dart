import 'dart:core';
import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/model/carta.dart';
import 'package:hablemos/util/snapshotConvertes.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/ux/loading_screen.dart';

class ListAprovedLettersPro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          List<Carta> cartas = ModalRoute.of(context).settings.arguments;
          if (ModalRoute.of(context).settings.arguments == null) {
            cartas = cartaMapToList(snapshot, true);
          }

          Size size = MediaQuery.of(context).size;
          return Stack(
            children: [
              Container(
                //Background Image
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
                  appBar: crearAppBarCitas(
                      context,
                      'cartasPrincipalProfesional',
                      "Cartas",
                      null,
                      0,
                      null,
                      Icons.shuffle, () {
                    Navigator.pushNamed(context, "verCarta",
                        arguments: cartas[Random().nextInt(cartas.length)]);
                  }),
                  body: Stack(
                    children: <Widget>[
                      // Contents
                      Material(
                        type: MaterialType.transparency,
                        child: Padding(
                          padding: EdgeInsets.only(top: 100.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: letterToCard(
                                  context, size, cartas, "verCartaPro", true),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: Colors.yellow[700],
                    child: Icon(Icons.add),
                    onPressed: () {
                      Navigator.pushNamed(context, "escribirCartaPro");
                    },
                  ),
                ),
              ),
            ],
          );
        });
  }
}
