import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/carta.dart';
import 'package:hablemos/util/snapshotConvertes.dart';
import 'package:hablemos/ux/atoms.dart';

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
            return CircularProgressIndicator();
          }
          List<Carta> cartas = cartaMapToList(snapshot);
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
                              children: letterToCard(context, size, cartas),
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

  List<Widget> letterToCard(
      BuildContext context, Size size, List<Carta> cartas) {
    // TODO: Convertir en atomo
    List<Widget> cards = [];
    cartas.forEach((element) {
      if (element.aprobado == false) {
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
            Navigator.pushNamed(context, "valorarCartaPro", arguments: element);
          },
          child: card,
        );
        cards.add(inkWell);
      }
    });
    return cards;
  }
}
