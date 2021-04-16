import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/paciente.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/services/providers/pacientes_provider.dart';
import 'package:hablemos/services/providers/profesionales_provider.dart';
import 'package:hablemos/util/snapshotConvertes.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';

class ListCitasPro extends StatelessWidget {
  final Paciente paciente = PacientesProvider.getPaciente();

  List<Widget> citasProfesionalToCard(
      Paciente paciente, context, List<Cita> citas) {
    final DateFormat format = DateFormat('hh:mm a');
    String nombrePaciente = paciente.nombre;
    List<Widget> cards = [];
    citas.forEach((element) {
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
          Navigator.pushNamed(context, 'detalleCitasProfesional',
              arguments: element);
        },
        child: card,
      );
      cards.add(inkWell);
    });
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String uid = "AYF5kJ1WhCQo631yi95JLz1xh062";
    CollectionReference citasCollection = FirebaseFirestore.instance
        .collection("appoinments")
        .where("uidProfessional",
            isEqualTo:
                uid); //TODO: APlicar filtro where uidProfesional = current user.

    return StreamBuilder<QuerySnapshot>(
        stream: citasCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('ALGO SALIO MAL');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          List<Cita> citas = citaMapToList(snapshot);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: crearAppBar(
                "Citas", Icons.calendar_today_outlined, heroCita, kRojoOscuro),
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
                            citasProfesionalToCard(paciente, context, citas),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
