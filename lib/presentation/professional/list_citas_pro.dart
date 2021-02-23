import 'package:flutter/material.dart';
import 'package:hablemos/model/paciente.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/services/providers/pacientes_provider.dart';
import 'package:hablemos/services/providers/profesionales_provider.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class ListCitasPro extends StatelessWidget {
  final Profesional profesional = ProfesionalesProvider.getProfesional();
  final Paciente paciente = PacientesProvider.getPaciente();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: crearAppBar('Citas', null, 0, null),
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/dateBack.png',
            alignment: Alignment.center,
            fit: BoxFit.fill,
            width: size.width,
            height: size.height,
          ),
          Material(
            type: MaterialType.transparency,
            child: Padding(
              padding: EdgeInsets.only(top: 80.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:
                      citasProfesionalToCard(profesional, paciente, context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> citasProfesionalToCard(
      Profesional profesional, Paciente paciente, context) {
    final DateFormat format = DateFormat('hh:mm a');
    String nombrePaciente = paciente.nombre;
    List<Widget> cards = [];
    profesional.citas.forEach((element) {
      Card card = Card(
        elevation: 5,
        margin: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Icon(Icons.access_alarm),
              SizedBox(height: 5),
              Text('Cita con $nombrePaciente'),
              SizedBox(height: 10),
              secction(
                  title: 'Hora', text: '${format.format(element.dateTime)}'),
              secction(
                  title: 'Fecha',
                  text:
                      '${element.dateTime.day}/${element.dateTime.month}/${element.dateTime.year}'),
              secction(title: 'Costo', text: '\$${element.costo}'),
              SizedBox(height: 20)
            ],
          ),
        ),
      );
      InkWell inkWell = InkWell(
        splashColor: kAmarillo,
        onTap: () {
          Navigator.pushNamed(context, 'detalleCitasProfesional');
        },
        child: card,
      );
      cards.add(inkWell);
    });
    return cards;
  }
}
