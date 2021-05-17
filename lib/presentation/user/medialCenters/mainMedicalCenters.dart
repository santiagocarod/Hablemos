import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/centro_atencion.dart';
import 'package:hablemos/util/snapshotConvertes.dart';
import 'package:hablemos/ux/EncabezadoMedical.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/ux/loading_screen.dart';

//TODO: HACER LA CONSULTA A FIREBASE DESDE AQUI PARA QUE SOLO SE TENGA QUE HACE 1 VEZ Y DE RESTO PASARLA POR PARAMETRO
class MainMedicalCenter extends StatelessWidget {
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
          return loadingScreen();
        }
        List<CentroAtencion> _medicalCenters = centrosMapToList(snapshot);
        return Container(
          color: kRosado,
          child: SafeArea(
            bottom: false,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              extendBodyBehindAppBar: true,
              appBar: crearAppBar('', null, 0, null, context: context),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    EncabezadoMedical(
                      size: size,
                      text1: "Canales de Ayuda",
                    ),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ButtonMedicalCenters(
                              "Lista\nCercanos",
                              () => Navigator.pushNamed(
                                  context, "listCentrosMedicos",
                                  arguments: _medicalCenters),
                              95.0),
                          SizedBox(height: size.height * 0.03),
                          ButtonMedicalCenters("Gratuitos", () {
                            List<CentroAtencion> gratuitos = [];
                            _medicalCenters.forEach((element) {
                              if (element.gratuito) {
                                gratuitos.add(element);
                              }
                            });
                            Navigator.pushNamed(context, "listCentrosMedicos",
                                arguments: gratuitos);
                          }, 95.0),
                          SizedBox(height: size.height * 0.03),
                          ButtonMedicalCenters("Pagos", () {
                            List<CentroAtencion> pagos = [];
                            _medicalCenters.forEach((element) {
                              if (!element.gratuito) {
                                pagos.add(element);
                              }
                            });
                            Navigator.pushNamed(context, "listCentrosMedicos",
                                arguments: pagos);
                          }, 95.0),
                          SizedBox(height: size.height * 0.03),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            width: (size.width / 2) - 20,
                            child: ButtonMedicalCenters("Ciudad", () {
                              List<String> ciudades = [];
                              _medicalCenters.forEach((element) {
                                if (!ciudades.contains(element.ciudad)) {
                                  ciudades.add(element.ciudad);
                                }
                              });
                              Map arguments = {
                                "filter": "Ciudad",
                                "centers": _medicalCenters,
                                "locations": ciudades
                              };
                              Navigator.pushNamed(
                                  context, "filterMedicalCenters",
                                  arguments: arguments);
                            }, 90.0)),
                        Container(
                          width: (size.width / 2) - 20,
                          child: ButtonMedicalCenters("Departamento", () {
                            List<String> departamentos = [];
                            _medicalCenters.forEach((element) {
                              if (!departamentos
                                  .contains(element.departamento)) {
                                departamentos.add(element.departamento);
                              }
                            });
                            Map arguments = {
                              "filter": "Departamento",
                              "centers": _medicalCenters,
                              "locations": departamentos
                            };
                            Navigator.pushNamed(context, "filterMedicalCenters",
                                arguments: arguments);
                          }, 90.0),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.03),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ButtonMedicalCenters extends StatelessWidget {
  final String _text;
  final Function _function;
  final double heighButton;
  ButtonMedicalCenters(this._text, this._function, this.heighButton);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heighButton,
      child: ElevatedButton(
        onPressed: () => _function(),
        child: FittedBox(
          child: AutoSizeText(
            _text,
            maxFontSize: 20.0,
            minFontSize: 17.0,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: kLetras, fontSize: 20.0, fontFamily: 'PoppinsRegular'),
          ),
        ),
        style: ElevatedButton.styleFrom(
            primary: kBlanco,
            elevation: 5,
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
