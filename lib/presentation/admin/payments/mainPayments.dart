import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/model/pagoadmin.dart';
import 'package:hablemos/services/providers/administrador_provider.dart';
import 'package:hablemos/services/providers/pago_admin_provider.dart';
import 'package:hablemos/util/snapshotConvertes.dart';
import 'package:hablemos/ux/atoms.dart';

import '../../../constants.dart';

class MainPaymentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    CollectionReference pagosCollecion =
        FirebaseFirestore.instance.collection('payments');

    return StreamBuilder<QuerySnapshot>(
      stream: pagosCollecion.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('ALGO SALIO MAL');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        List<Pagoadmin> lista = paymentMapToList(snapshot);

        return SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              extendBodyBehindAppBar: true,
              appBar: crearAppBar("Pagos", null, 0, null),
              body: Stack(
                children: <Widget>[
                  _background(size),
                  _crearBody(context, size, lista),
                ],
              )),
        );
      },
    );
  }

  // Display Backgorund
  Widget _background(Size size) {
    return Image.asset(
      'assets/images/verdeAdminPagos.png',
      alignment: Alignment.center,
      fit: BoxFit.fill,
      width: size.width,
      height: size.height,
    );
  }

  Widget _crearBody(BuildContext context, Size size, List<Pagoadmin> lista) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: size.height * 0.3,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Image.asset("assets/images/dinero.png"),
                ),
                SizedBox(width: 20),
                Text(
                  'Pagos',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'PoppinsRegular',
                    fontSize: 30.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: _crearTabla(context, size, lista),
          ),
        ),
      ],
    );
  }

  Widget _crearTabla(BuildContext context, Size size, List<Pagoadmin> lista) {
    List<DataRow> rows = [];

    lista.forEach((element) {
      String nombreProfesional =
          element.profesional.nombre + " " + element.profesional.apellido;
      int valor = element.pago;
      DataRow data = DataRow(
        cells: [
          DataCell(
              Text(
                "$nombreProfesional",
                style: GoogleFonts.montserrat(
                    fontSize: 17.0, fontWeight: FontWeight.w300),
                overflow: TextOverflow.ellipsis,
              ), onTap: () {
            Navigator.pushNamed(context, "principalPagoAdmin",
                arguments: element);
          }),
          DataCell(
              Text(
                "$valor",
                style: GoogleFonts.montserrat(
                    fontSize: 17.0, fontWeight: FontWeight.w300),
                overflow: TextOverflow.ellipsis,
              ), onTap: () {
            Navigator.pushNamed(context, "principalPagoAdmin",
                arguments: element);
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
            return kVerdePagos.withOpacity(0.5);
          }),
          columns: [
            DataColumn(
              label: Text(
                "NOMBRE PROFESIONAL",
                style:
                    GoogleFonts.montserrat(fontSize: 10.0, letterSpacing: 2.0),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            DataColumn(
              label: Text(
                "VALOR A PAGAR",
                style:
                    GoogleFonts.montserrat(fontSize: 10.0, letterSpacing: 2.0),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
          rows: rows),
    );
  }
}
