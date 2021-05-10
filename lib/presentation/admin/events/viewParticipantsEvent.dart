import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/taller.dart';
import 'package:hablemos/ux/atoms.dart';

class ParticipantsEvent extends StatefulWidget {
  @override
  _ParticipantsEventState createState() => _ParticipantsEventState();
}

class _ParticipantsEventState extends State<ParticipantsEvent> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Taller taller = ModalRoute.of(context).settings.arguments;
    return Stack(
      children: [
        Container(
          child: Image.asset(
            'assets/images/eventsAdminBackground.png',
            alignment: Alignment.center,
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
                context, "${taller.titulo}", "listarTalleresAdmin"),
            body: Stack(
              children: <Widget>[
                _crearBody(context, size, taller),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _crearBody(BuildContext context, Size size, Taller taller) {
    print("EYYYYYYYYYYYY");
    print(taller.participantes);

    if (taller.participantes == null || taller.participantes.length == 0) {
      return Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Text("No hay inscritos aún"),
          ),
        ),
      );
    }

    int totalInscritos = taller.participantes.length;
    return Container(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            _createText(context, size, "Total: ", totalInscritos.toString()),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: _createTable(context, size, taller.participantes),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createText(
      BuildContext context, Size size, String titulo, String total) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            titulo,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            total,
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _createTable(
      BuildContext context, Size size, List<dynamic> participantes) {
    List<DataRow> rows = [];

    participantes.forEach((element) {
      String nombreParticipante = element["name"] + " " + element["lastName"];
      String telefono = element["phone"];

      DataRow data = DataRow(cells: [
        DataCell(
          Text(
            "$nombreParticipante",
            style: GoogleFonts.montserrat(
                fontSize: 17.0, fontWeight: FontWeight.w300),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        DataCell(
          Text(
            "$telefono",
            style: GoogleFonts.montserrat(
                fontSize: 15.0, fontWeight: FontWeight.w300),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ]);
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
            return kAmarillo.withOpacity(0.5);
          }),
          columns: [
            DataColumn(
              label: Text(
                "PARTICIPANTE",
                style:
                    GoogleFonts.montserrat(fontSize: 10.0, letterSpacing: 2.0),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            DataColumn(
              label: Text(
                "TELEFONO",
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
