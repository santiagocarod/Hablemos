import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/model/diagnostico.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/util/snapshotConvertes.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Information extends StatelessWidget {
  final List<String> names = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    CollectionReference diagnosticosCollection =
        FirebaseFirestore.instance.collection("diagnostics");

    return StreamBuilder<QuerySnapshot>(
      stream: diagnosticosCollection.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('ALGO SALIO MAL');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        List<Diagnostico> diagnosticos = diagnosticoMapToList(snapshot);

        diagnosticos.forEach((element) {
          names.add(element.nombre);
        });

        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: crearAppBar('', null, 0, null),
            extendBodyBehindAppBar: true,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  crearForosUpper(size, 'Informémonos \ny hablemos',
                      Icons.monitor, 0.05, kAmarillo),
                  Container(
                    padding:
                        EdgeInsets.only(top: size.height * 0.102, bottom: 0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: GestureDetector(
                              onTap: () {
                                showSearch(
                                    context: context,
                                    delegate: DataSearch(
                                        names: names,
                                        elements: diagnosticos,
                                        route: 'DetalleInformacion'));
                              },
                              child: Container(
                                width: size.width - 120.0,
                                height: 43.33,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(378.0),
                                  border: Border.all(color: kRosado),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(left: 10.0),
                                      child: Icon(
                                        Icons.search_rounded,
                                        color: kRosado,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        'Buscar Temas',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: kAzulOscuro,
                                            fontFamily: 'PoppinsSemiBold'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: _information(context, diagnosticos, size),
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

List<Widget> _information(
    BuildContext context, List<Diagnostico> trastornos, Size size) {
  List<Widget> topics = [];

  trastornos.forEach((element) {
    Container topic = Container(
      padding: EdgeInsets.only(left: 60.0, right: 60.0, bottom: 32.0),
      width: size.width,
      height: 73.33,
      child: ElevatedButton(
        child: Text(
          element.nombre,
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.black,
            fontFamily: 'PoppinsSemiBold',
          ),
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
          primary: kCuruba,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(378.0),
          ),
          shadowColor: Colors.black,
        ),
        onPressed: () {
          Navigator.pushNamed(context, 'DetalleInformacion',
              arguments: element);
        },
      ),
    );
    topics.add(topic);
  });

  return topics;
}
