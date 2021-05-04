import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/util/snapshotConvertes.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/ux/loading_screen.dart';
import 'package:intl/intl.dart';

class ListCitas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final FirebaseAuth auth = FirebaseAuth.instance; //OBTENER EL USUARIO ACTUAL
    final User user = auth.currentUser;

    Query citasCollection = FirebaseFirestore.instance
        .collection("appoinments")
        .where("pacient.uid", isEqualTo: user.uid);

    return StreamBuilder<QuerySnapshot>(
        stream: citasCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Text('ALGO SALIO MAL');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingScreen();
          }
          List<Cita> citas = citaMapToList(snapshot);
          return Stack(
            children: [
              Container(
                //Background Image
                child: Image.asset(
                  'assets/images/dateBack.png',
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                  width: size.width,
                  height: size.height,
                ),
              ),
              SafeArea(
                bottom: false,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  resizeToAvoidBottomInset: false,
                  extendBodyBehindAppBar: true,
                  appBar: crearAppBarEventos(context, 'Citas', 'inicio'),
                  body: Stack(
                    children: <Widget>[
                      // Contents
                      Padding(
                        padding: EdgeInsets.only(top: 100.0),
                        child: Material(
                          type: MaterialType.transparency,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: citasToCard(citas, context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    child: Icon(Icons.add),
                    backgroundColor: kRojoOscuro,
                    onPressed: () {
                      Cita cita;
                      Navigator.pushNamed(context, 'CrearCita',
                          arguments: cita);
                    },
                  ),
                ),
              ),
            ],
          );
        });
  }

  List<Widget> citasToCard(List<Cita> citas, BuildContext context) {
    final DateFormat format = DateFormat('hh:mm a');
    List<Widget> cards = [];
    citas.forEach((element) {
      Profesional profesional = element.profesional;
      Card card = Card(
        elevation: 5,
        margin: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        shadowColor: Colors.black.withOpacity(1.0),
        child: Center(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Icon(Icons.access_alarm),
            SizedBox(
              height: 5,
            ),
            Text(
                'Cita con ${profesional.nombre} ${profesional.apellido}'), //Text("Cita con ${element.uidProfesional}"),
            SizedBox(
              height: 10,
            ),
            secction(title: "Hora", text: '${format.format(element.dateTime)}'),
            secction(
                title: "Fecha",
                text:
                    '${element.dateTime.day}/${element.dateTime.month}/${element.dateTime.year}'),
            secction(title: "Costo", text: "\$${element.costo}"),
            SizedBox(
              height: 20,
            )
          ],
        )),
      );
      InkWell inkWell = InkWell(
        splashColor: kAmarillo,
        onTap: () {
          Navigator.pushNamed(context, 'DetalleCita', arguments: element);
        },
        child: card,
      );
      cards.add(inkWell);
    });
    // Button

    return cards;
  }
}
