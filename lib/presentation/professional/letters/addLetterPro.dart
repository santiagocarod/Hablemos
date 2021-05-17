import 'dart:core';

import 'package:flutter/material.dart';
import 'package:hablemos/business/pacient/negocioCartas.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/carta.dart';
import 'package:hablemos/ux/atoms.dart';

class AddLetterPro extends StatefulWidget {
  @override
  _AddLetterPro createState() => _AddLetterPro();
}

class _AddLetterPro extends State<AddLetterPro> {
  TextEditingController tituloCarta = new TextEditingController();
  TextEditingController contenidoCarta = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
            appBar: crearAppBarEventos(
                context, 'Escribe tu Carta', 'listarCartasPro'),
            body: Stack(
              children: <Widget>[
                Material(
                  type: MaterialType.transparency,
                  child: Padding(
                    padding: EdgeInsets.only(top: 120.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.1),
                            child: TextField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.name,
                              controller: tituloCarta,
                              decoration: InputDecoration(
                                labelText: "Título",
                                fillColor: kLetras,
                                icon: Icon(
                                  Icons.title,
                                  color: Colors.yellow[700],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.1,
                                vertical: size.height * 0.05),
                            child: Center(
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                minLines: 20,
                                maxLines: 50,
                                controller: contenidoCarta,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: kLetras))),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (tituloCarta.text.isNotEmpty &&
                                  contenidoCarta.text.isNotEmpty) {
                                Carta nuevaCarta = new Carta(
                                    titulo: tituloCarta.text,
                                    cuerpo: contenidoCarta.text,
                                    aprobado: true);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      _buildDialog(context, nuevaCarta, size),
                                );
                              }
                            },
                            child: Container(
                              width: 239.0,
                              height: 43.0,
                              margin:
                                  EdgeInsets.only(bottom: size.height * 0.04),
                              decoration: BoxDecoration(
                                color: Colors.yellow[700],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 0),
                                      blurRadius: 5,
                                      color: Colors.grey.withOpacity(0.5)),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  "ENVIAR CARTA",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: kBlanco,
                                      fontSize: 18.0,
                                      fontFamily: 'PoppinsSemiBold',
                                      letterSpacing: 2.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Dialogo Confirmación de Envío de Carta.
  Widget _buildDialog(BuildContext context, Carta carta, Size size) {
    String title = "";
    String content = "";
    return new AlertDialog(
      title: Text(
        'Confirmación Envío de Carta',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kNegro,
          fontSize: 15.0,
          fontFamily: 'PoppinsRegular',
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        '¿Estás seguro que desea enviar esta carta?',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kNegro,
          fontSize: 14.0,
          fontFamily: 'PoppinsRegular',
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(37.0),
        side: BorderSide(color: kNegro, width: 2.0),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  agregarCarta(carta).then((value) {
                    bool state;
                    if (value) {
                      title = 'Carta enviada';
                      content =
                          "Su carta fue enviada exitosamente, espere la aprobación de nuestro equipo para su publicación";
                      state = true;
                    } else {
                      title = 'Error de envío';
                      content =
                          "Hubo un error enviando la carta, inténtelo nuevamente";
                      state = false;
                    }
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => adviceDialogLetter(
                              context,
                              title,
                              content,
                              state,
                            ));
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(99.0, 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0),
                    side: BorderSide(color: kNegro),
                  ),
                  shadowColor: Colors.black,
                ),
                child: const Text(
                  'Si',
                  style: TextStyle(
                    color: kNegro,
                    fontSize: 14.0,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.065,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(99.0, 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0),
                    side: BorderSide(color: kNegro),
                  ),
                  shadowColor: Colors.black,
                ),
                child: const Text(
                  'No',
                  style: TextStyle(
                    color: kNegro,
                    fontSize: 14.0,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
