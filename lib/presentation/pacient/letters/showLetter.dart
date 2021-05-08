import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/model/carta.dart';

class ShowLetter extends StatelessWidget {
  final Carta carta = Carta();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Carta carta = ModalRoute.of(context).settings.arguments;
    return Stack(
      children: [
        Container(
          child: Image.asset(
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
              appBar: crearAppBar("Carta", null, 0, null, context: context),
              body: Stack(children: <Widget>[
                Material(
                  type: MaterialType.transparency,
                  child: Padding(
                    padding: EdgeInsets.only(top: 80.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Text(
                              carta.titulo,
                              style: TextStyle(
                                  fontFamily: "PoppinSemiBold", fontSize: 24),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
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
                )
              ])),
        ),
      ],
    );
  }
}
