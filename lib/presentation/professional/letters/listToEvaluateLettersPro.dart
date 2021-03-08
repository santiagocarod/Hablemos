import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/carta.dart';
import 'package:hablemos/services/providers/cartas_provider.dart';
import 'package:hablemos/ux/atoms.dart';

class ListToEvaluateLettersPro extends StatelessWidget {
  final List<Carta> cartas = CartaProvider.getCartas();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBar("Cartas a Valorar", null, 0, null),
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
    );
  }
}

List<Widget> letterToCard(BuildContext context, Size size, List<Carta> cartas) {
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
                  style: TextStyle(fontSize: 22, fontFamily: "PoppinSemiBold")),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 20),
                child: Text(
                    (element.cuerpo.length <= 250)
                        ? element.cuerpo
                        : "${element.cuerpo.substring(0, 250)} ...",
                    style:
                        TextStyle(fontFamily: "PoppinsRegular", fontSize: 14)),
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
