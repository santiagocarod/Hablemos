import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/util/snapshotConvertes.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/ux/loading_screen.dart';

/// Clase que tiene el diseño de la pantalla principal de los [Profeisonal]es
/// Es desde la perspectiva de un admnistrador y va a ver un listado de estos.
class HomeProfessionalsManagement extends StatefulWidget {
  @override
  _HomeProfessionalsManagementState createState() =>
      _HomeProfessionalsManagementState();
}

class _HomeProfessionalsManagementState
    extends State<HomeProfessionalsManagement> {
  //Profesional profesional = ProfesionalesProvider.getProfesional();
  ScrollController scrollController = ScrollController(
    initialScrollOffset: 0,
    keepScrollOffset: true,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    CollectionReference professionalsCollection =
        FirebaseFirestore.instance.collection("professionals");
    return StreamBuilder<QuerySnapshot>(
        stream: professionalsCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('ALGO SALIO MAL');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingScreen();
          }
          List<Profesional> profesionales =
              ModalRoute.of(context).settings.arguments;
          if (ModalRoute.of(context).settings.arguments == null) {
            profesionales = profesionalMapToList(snapshot);
          }

          return Stack(
            children: [
              Container(
                child: Image.asset(
                  'assets/images/azulDegradado.png',
                  alignment: Alignment.topCenter,
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
                      context, 'Personal de salud', 'inicioAdministrador'),
                  body: Stack(
                    children: [
                      _body(context, size, profesionales),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  ///Diseño del body de la pantalla
  Widget _body(
      BuildContext context, Size size, List<Profesional> profesionales) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height * 0.13,
            width: double.infinity,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.person_outline_sharp,
                size: 90.0,
                color: kLetras,
              ),
              SizedBox(
                width: 15.0,
              ),
              Text(
                "Personal de Salud",
                style: GoogleFonts.montserrat(
                    color: kLetras,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
          Container(
            height: size.height * 0.05,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'crearPerfilProfesionalManage');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(Icons.add_circle_outline),
                  SizedBox(width: 5),
                  Container(
                    child: Text('Agregar'),
                  ),
                  SizedBox(width: size.width * 0.04)
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          Center(child: _profesionalesTable(context, size, profesionales)),
        ],
      ),
    );
  }

  /// Diseño de la tabla de profesionales
  Widget _profesionalesTable(
      BuildContext context, Size size, List<Profesional> profesionales) {
    List<DataRow> rows = [];
    profesionales.forEach((element) {
      String titulo = element.nombre + " " + element.apellido;
      DataRow data = DataRow(
        cells: [
          DataCell(
              Text(
                "$titulo",
                style: GoogleFonts.montserrat(
                    fontSize: 17.0, fontWeight: FontWeight.w300),
              ), onTap: () {
            Navigator.pushNamed(context, 'verPerfilProfManage',
                arguments: element);
          }),
        ],
      );
      rows.add(data);
    });
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: size.width * 0.95),
        child: DataTable(
            headingRowHeight: 41.0,
            dataRowHeight: 50.0,
            sortColumnIndex: 0,
            showBottomBorder: true,
            sortAscending: true,
            headingRowColor: MaterialStateColor.resolveWith((states) {
              return kAguaMarina.withOpacity(0.4);
            }),
            columns: [
              DataColumn(
                label: Text(
                  "NOMBRE",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontSize: 12.0, letterSpacing: 2.0),
                ),
              ),
            ],
            rows: rows),
      ),
    );
  }
}
