import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:url_launcher/url_launcher.dart';

/// Clase que tiene el diseño de la pantalla principal de los ver los [Profeisonal]es y [Paciente]s inscritos a un evento
///
/// Es desde la perspectiva de un admnistrador y va a ver un listado referente al tipo de evento ([Actividad], [Taller], [Grupo]) que realice el llamado

class ParticipantsEvent extends StatefulWidget {
  @override
  _ParticipantsEventState createState() => _ParticipantsEventState();
}

class _ParticipantsEventState extends State<ParticipantsEvent> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    dynamic evento = ModalRoute.of(context).settings.arguments;
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
                context, "${evento.titulo}", "listarTalleresAdmin"),
            body: Stack(
              children: <Widget>[
                _crearBody(context, size, evento),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Diseño del cuerpo o body de la pantalla
  ///
  /// Despliega la lista de inscritos del evento
  /// En caso de que [Evento.participantes]  = `null` se desplegara un mensaje de la no existencia de pacientes inscritos
  Widget _crearBody(BuildContext context, Size size, dynamic evento) {
    if (evento.participantes == null || evento.participantes.length == 0) {
      return Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Text("No hay inscritos aún"),
          ),
        ),
      );
    }

    int totalInscritos = evento.participantes.length;
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
                child:
                    _createTable(context, size, evento.participantes, evento),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Seccion especifica para identificar el total de los inscritos en el evento
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

  /// Hace la transformación del la lista de pacticipantes a una tabla, la cual puede ser vista de mejor manera
  ///
  /// Cada fila representa un participante individual e indica su nombre
  Widget _createTable(BuildContext context, Size size,
      List<dynamic> participantes, dynamic event) {
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
            ), onTap: () {
          if (event.ubicacion.toLowerCase() == "virtual" &&
              event.valor != "sin costo" &&
              event.valor != "gratis" &&
              event.valor != "gratuito" &&
              event.valor != "0") {
            _launchInBrowser(element["payment"]);
          }
        }),
        DataCell(
            Text(
              "$telefono",
              style: GoogleFonts.montserrat(
                  fontSize: 15.0, fontWeight: FontWeight.w300),
              overflow: TextOverflow.ellipsis,
            ), onTap: () {
          if (event.ubicacion.toLowerCase() == "virtual" &&
              event.valor != "sin costo" &&
              event.valor != "gratis" &&
              event.valor != "gratuito" &&
              event.valor != "0") {
            _launchInBrowser(element["payment"]);
          }
        })
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

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
