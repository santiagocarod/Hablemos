import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/carta.dart';

class ShowLetterPro extends StatelessWidget {
  final Carta carta = Carta();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Carta carta = ModalRoute.of(context).settings.arguments;
    return Stack(
      children: [
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
            appBar: appBarCarta(carta.titulo, null, 0, null),
            body: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Center(
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
                      child: Material(
                        type: MaterialType.transparency,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.0),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 25, 20, 20),
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

AppBar appBarCarta(String texto, IconData icono, int constante, Color color) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(icono, color: color),
      ),
    ],
    title: Text(
      texto,
      style: TextStyle(
          color: kLetras, fontSize: 20.0, fontFamily: 'PoppinsRegular'),
    ),
    centerTitle: true,
    iconTheme: IconThemeData(
      color: Colors.black, //change your color here
    ),
  );
}
