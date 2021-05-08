import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/taller.dart';
import 'package:hablemos/services/providers/eventos_provider.dart';
import 'package:hablemos/util/snapshotConvertes.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/ux/loading_screen.dart';

class ListWorkShopsAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CollectionReference talleresCollection =
        FirebaseFirestore.instance.collection("workshops");

    return StreamBuilder<QuerySnapshot>(
        stream: talleresCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('ALGO SALIO MAL');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingScreen();
          }

          List<Taller> talleres = tallerMapToList(snapshot);

          return Container(
            color: kAmarilloClaro,
            child: SafeArea(
              bottom: false,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                extendBodyBehindAppBar: true,
                appBar: crearAppBarEventos(
                    context, "Talleres", "eventosAdministrador"),
                body: Stack(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/eventsAdminBackground.png',
                      alignment: Alignment.center,
                      fit: BoxFit.fill,
                      width: size.width,
                      height: size.height,
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: size.height * 0.15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.transfer_within_a_station_outlined,
                                size: 90.0,
                                color: kLetras,
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(
                                "Talleres",
                                style: GoogleFonts.montserrat(
                                    color: kLetras,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "agregarTaller");
                            },
                            child: Container(
                              width: size.width * 0.9,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Icon(
                                    Icons.add_circle_outline,
                                    size: 28.0,
                                    color: kLetras,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    "Agregar",
                                    style: GoogleFonts.montserrat(
                                        color: kLetras,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(width: size.width * 0.03)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          _talleresTable(context, size, talleres),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _talleresTable(
      BuildContext context, Size size, List<Taller> talleres) {
    List<DataRow> rows = [];
    talleres.forEach((element) {
      String titulo = element.titulo;
      String fecha = element.fecha;
      DataRow data = DataRow(
        cells: [
          DataCell(
              Text(
                "$titulo",
                style: GoogleFonts.montserrat(
                    fontSize: 17.0, fontWeight: FontWeight.w300),
              ), onTap: () {
            Navigator.pushNamed(context, "verTallerAdmin", arguments: element);
          }),
          DataCell(
              Text(
                "$fecha",
                style: GoogleFonts.montserrat(
                    fontSize: 17.0, fontWeight: FontWeight.w300),
              ), onTap: () {
            Navigator.pushNamed(context, "verTallerAdmin", arguments: element);
          })
        ],
      );
      rows.add(data);
    });
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: size.width * 0.95),
      child: DataTable(
          headingRowHeight: 41.0,
          dataRowHeight: 80.0,
          sortColumnIndex: 0,
          showBottomBorder: true,
          sortAscending: true,
          headingRowColor: MaterialStateColor.resolveWith((states) {
            return kAmarilloClaro.withOpacity(0.5);
          }),
          columns: [
            DataColumn(
              label: Text(
                "NOMBRE",
                style:
                    GoogleFonts.montserrat(fontSize: 12.0, letterSpacing: 2.0),
              ),
            ),
            DataColumn(
              label: Text(
                "FECHA",
                style:
                    GoogleFonts.montserrat(fontSize: 12.0, letterSpacing: 2.0),
              ),
            ),
          ],
          rows: rows),
    );
  }
}
