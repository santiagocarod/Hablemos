import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/model/centro_atencion.dart';
import 'package:hablemos/util/snapshotConvertes.dart';
import 'package:hablemos/ux/EncabezadoMedicalAdmin.dart';
import 'package:hablemos/ux/atoms.dart';

import '../../../constants.dart';

class ListMedicalAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CollectionReference centroMedicoCollection =
        FirebaseFirestore.instance.collection("attentionCenters");
    return StreamBuilder<QuerySnapshot>(
        stream: centroMedicoCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('ALGO SALIO MAL');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          List<CentroAtencion> _medicalCenters = centrosMapToList(snapshot);
          return Scaffold(
              resizeToAvoidBottomInset: false,
              extendBodyBehindAppBar: true,
              appBar: crearAppBar('', null, 0, null),
              body: Column(
                children: <Widget>[
                  EncabezadoMedicalAdmin(size: size, text1: "Canales de Ayuda"),
                  Espacio(size: size),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 40),
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, "newCentrosMedicosAdmin"),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add_circle_outline,
                                size: 40,
                              ),
                              Text("Agregar",
                                  style: TextStyle(
                                      color: kLetras,
                                      fontSize: 26,
                                      fontFamily: "PoppinsRegular"))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Espacio(size: size),
                  Container(
                    width: size.width - 20,
                    color: kAzul1,
                    child: Center(
                      child: Text("Lineas de ayuda",
                          style: TextStyle(
                              color: kLetras,
                              fontSize: 26,
                              fontFamily: "PoppinsRegular")),
                    ),
                  ),
                  Espacio(size: size),
                  Expanded(
                      child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    children: centersToWidgetsMedical(context, _medicalCenters),
                  ))
                ],
              ));
        });
  }

  List<Widget> centersToWidgetsMedical(
      BuildContext context, List<CentroAtencion> _medicalCenters) {
    List<Widget> widgets = [];
    _medicalCenters.forEach((element) {
      Card card = Card(
        child: Container(
            height: 70,
            child: Center(
                child: Text(
              element.nombre + "\n" + element.telefono,
              style: TextStyle(
                  color: kLetras, fontSize: 22, fontFamily: "PoppinsRegular"),
            ))),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 7,
      );

      InkWell inkWell = InkWell(
        splashColor: kAmarillo,
        onTap: () {
          Navigator.pushNamed(context, "detailsCentrosMedicosAdmin",
              arguments: element);
        },
        child: card,
      );
      widgets.add(inkWell);
      widgets.add(SizedBox(
        height: 10,
      ));
    });

    return widgets;
  }
}