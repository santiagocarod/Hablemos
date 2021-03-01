import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/constants.dart';

class valorarCartasPro extends StatelessWidget {
  valorarCartasPro({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/lettersBackground.png',
            alignment: Alignment.center,
            fit: BoxFit.fill,
            width: size.width,
            height: size.height,
          ),
          Container(
            padding: EdgeInsets.only(
              top: size.height * 0.06,
            ),
            alignment: Alignment.center,
            width: size.width,
            child: Column(children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _pageHeader(context, size, "Cartas"),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[],
                  )
                ],
              )
            ]),
          )
        ],
      ),
    );
  }
}

Widget _pageHeader(BuildContext context, Size size, String titulo) {
  return Container(
    padding: EdgeInsets.only(bottom: size.height * 0.03),
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
                Icons.arrow_back,
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
        SizedBox(width: size.width * 0.05),
      ],
    ),
  );
}
