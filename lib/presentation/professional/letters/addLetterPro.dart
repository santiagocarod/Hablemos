import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/carta.dart';
import 'package:hablemos/util/snapshotConvertes.dart';
import 'package:hablemos/ux/atoms.dart';

class AddLetterPro extends StatelessWidget {
  final TextEditingController tituloCarta = TextEditingController();
  final TextEditingController contenidoCarta = TextEditingController();
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

          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              extendBodyBehindAppBar: true,
              appBar: crearAppBarEventos(
                  context, 'Escribe tu Carta', 'listarCartasPro'),
              body: Stack(
                children: <Widget>[
                  Image.asset(
                    'assets/images/lettersBackground.png',
                    alignment: Alignment.center,
                    fit: BoxFit.fill,
                    width: size.width,
                    height: size.height,
                  ),
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
                                Carta nuevaCarta = new Carta(
                                    titulo: tituloCarta.text,
                                    cuerpo: contenidoCarta.text,
                                    aprobado: true);
                                cartas.add(nuevaCarta);
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return dialogoConfirmacion(
                                          context,
                                          'listarCartasPro',
                                          "Confirmación Envio de Carta",
                                          "¿Estás seguro que deseas enviar esta carta?");
                                    });
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
          );
        });
  }
}
