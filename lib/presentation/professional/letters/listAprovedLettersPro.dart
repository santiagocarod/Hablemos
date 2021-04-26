import 'dart:core';
import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/carta.dart';
import 'package:hablemos/util/snapshotConvertes.dart';
import 'package:hablemos/ux/atoms.dart';

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
            return CircularProgressIndicator();
          }
          List<Carta> cartas = ModalRoute.of(context).settings.arguments;
          if (ModalRoute.of(context).settings.arguments == null) {
            cartas = cartaMapToList(snapshot);
          }

          Size size = MediaQuery.of(context).size;
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              extendBodyBehindAppBar: true,
              appBar:
                  crearAppBarAction("Cartas", null, 0, null, Icons.shuffle, () {
                Navigator.pushNamed(context, "verCarta",
                    arguments: cartas[Random().nextInt(cartas.length)]);
              }),
              body: Stack(
                children: <Widget>[
                  //Background Image
                  Image.asset(
                    'assets/images/lettersBackground.png',
                    alignment: Alignment.center,
                    fit: BoxFit.fill,
                    width: size.width,
                    height: size.height,
                  ),
                  // Contents
                  Material(
                    type: MaterialType.transparency,
                    child: Padding(
                      padding: EdgeInsets.only(top: 100.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: letterToCard(context, size, cartas),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: kRojoOscuro,
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, "escribirCartaPro");
                },
              ),
            ),
          );
        });
  }

  List<Widget> letterToCard(
      BuildContext context, Size size, List<Carta> cartas) {
    //TODO: CONVERTIR ESTO EN ATOM PARA PACIENTE Y PROFESIONAL
    List<Widget> cards = [];
    cartas.forEach((element) {
      if (element.aprobado == true) {
        Card card = Card(
          elevation: 5,
          margin: EdgeInsets.only(
              top: 60.0, left: size.width * 0.1, right: size.width * 0.1),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          shadowColor: Colors.black.withOpacity(1.0),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Icon(Icons.mail),
                SizedBox(
                  height: 5,
                ),
                Text("${element.titulo}",
                    style:
                        TextStyle(fontSize: 22, fontFamily: "PoppinSemiBold")),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 20),
                  child: Text(
                      (element.cuerpo.length <= 250)
                          ? element.cuerpo
                          : "${element.cuerpo.substring(0, 250)} ...",
                      style: TextStyle(
                          fontFamily: "PoppinsRegular", fontSize: 14)),
                )
              ],
            ),
          ),
        );
        InkWell inkWell = InkWell(
          splashColor: kRosado,
          onTap: () {
            Navigator.pushNamed(context, "verCartaPro", arguments: element);
          },
          child: card,
        );
        cards.add(inkWell);
      }
    });
    return cards;
  }
}
