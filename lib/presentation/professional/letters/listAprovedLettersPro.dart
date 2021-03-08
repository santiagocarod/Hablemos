import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/carta.dart';
import 'package:hablemos/services/providers/cartas_provider.dart';

class ListAprovedLettersPro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Carta> cartas = ModalRoute.of(context).settings.arguments;
    if (ModalRoute.of(context).settings.arguments == null) {
      cartas = CartaProvider.getCartas();
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
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
          Container(
            height: size.height * 0.1,
            margin: EdgeInsets.symmetric(vertical: size.height * 0.05),
            child: _pageHeader(context, size, "Cartas"),
            alignment: Alignment.center,
            width: size.width,
          ),
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
    );
  }
}

List<Widget> letterToCard(BuildContext context, Size size, List<Carta> cartas) {
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
          Navigator.pushNamed(context, "verCartaPro", arguments: element);
        },
        child: card,
      );
      cards.add(inkWell);
    }
  });
  return cards;
}

Widget _pageHeader(BuildContext context, Size size, String titulo) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "cartasPrincipalProfesional");
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
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 22, color: kNegro, decoration: TextDecoration.none),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "");
          },
          child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(right: size.width * 0.05),
              child: Icon(
                Icons.shuffle,
                size: 50,
                color: kNegro,
              )),
        ),
      ],
    ),
  );
}
