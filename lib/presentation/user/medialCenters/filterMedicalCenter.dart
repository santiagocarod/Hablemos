import 'package:flutter/material.dart';
import 'package:hablemos/model/centro_atencion.dart';
import 'package:hablemos/ux/EncabezadoMedical.dart';
import 'package:hablemos/ux/atoms.dart';

import '../../../constants.dart';

class FilterMedicalCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context).settings.arguments;
    List<String> locations = arguments["locations"];
    List<CentroAtencion> centrosAtencion = arguments["centers"];
    String filter = arguments["filter"];
    Size size = MediaQuery.of(context).size;
    return Container(
      color: kRosado,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: crearAppBar('', null, 0, null),
            body: Column(
              children: <Widget>[
                EncabezadoMedical(size: size, text1: "Filtro por " + filter),
                Espacio(size: size),
                Container(
                  width: size.width - 20,
                  color: kRosado,
                  child: Center(
                    child: Text(
                        filter == "Ciudad" ? "Ciudades" : "Departamentos",
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
                  children: locationsToWidgets(
                      context, locations, centrosAtencion, filter),
                ))
              ],
            )),
      ),
    );
  }

  locationsToWidgets(BuildContext context, List<String> locations,
      List<CentroAtencion> centrosAtencion, String filter) {
    List<Widget> widgets = [];
    locations.forEach((element) {
      Card card = Card(
        child: Container(
            height: 60,
            child: Center(
                child: Text(
              element,
              style: TextStyle(
                  color: kLetras, fontSize: 22, fontFamily: "PoppinsRegular"),
            ))),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 7,
      );

      InkWell inkWell = InkWell(
        splashColor: kAmarillo,
        onTap: () {
          List<CentroAtencion> centrosConFiltro = [];
          filter == "Ciudad"
              ? centrosAtencion.forEach((centroElement) {
                  if (centroElement.ciudad == element) {
                    centrosConFiltro.add(centroElement);
                  }
                })
              : centrosAtencion.forEach((centroElement) {
                  if (centroElement.departamento == element) {
                    centrosConFiltro.add(centroElement);
                  }
                });
          Navigator.pushNamed(context, "listCentrosMedicos",
              arguments: centrosConFiltro);
        },
        child: card,
      );
      widgets.add(inkWell);
    });

    return widgets;
  }
}
