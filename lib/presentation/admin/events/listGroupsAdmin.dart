import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/grupo.dart';
import 'package:hablemos/util/snapshotConvertes.dart';
import 'package:hablemos/ux/atoms.dart';

class ListGroupsAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    CollectionReference gruposCollection =
        FirebaseFirestore.instance.collection("groups");

    return StreamBuilder<QuerySnapshot>(
      stream: gruposCollection.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('ALGO SALIO MAL');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        List<Grupo> grupos = grupoMapToList(snapshot);

        return Container(
          color: kAmarilloClaro,
          child: SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              extendBodyBehindAppBar: true,
              appBar:
                  crearAppBarEventos(context, "Grupos", "eventosAdministrador"),
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
                              Icons.people_alt_outlined,
                              size: 90.0,
                              color: kLetras,
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              "Grupos",
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
                            Navigator.pushNamed(context, "agregarGrupo");
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
                        _talleresTable(context, size, grupos),
                      ],
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

  Widget _talleresTable(BuildContext context, Size size, List<Grupo> grupos) {
    List<DataRow> rows = [];
    grupos.forEach((element) {
      String titulo = element.titulo;
      String sesiones = element.numeroSesiones.toString();
      DataRow data = DataRow(
        cells: [
          DataCell(
              Text(
                "$titulo",
                style: GoogleFonts.montserrat(
                    fontSize: 17.0, fontWeight: FontWeight.w300),
              ), onTap: () {
            Navigator.pushNamed(context, "verGrupoAdmin", arguments: element);
          }),
          DataCell(
              Text(
                "$sesiones",
                style: GoogleFonts.montserrat(
                    fontSize: 17.0, fontWeight: FontWeight.w300),
              ), onTap: () {
            Navigator.pushNamed(context, "verGrupoAdmin", arguments: element);
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
                "SESIONES",
                style:
                    GoogleFonts.montserrat(fontSize: 12.0, letterSpacing: 2.0),
              ),
            ),
          ],
          rows: rows),
    );
  }
}
