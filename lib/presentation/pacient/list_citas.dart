import 'package:flutter/material.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/services/providers/citas_provider.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/presentation/pacient/dateDetails.dart';
import 'package:intl/intl.dart';

class ListCitas extends StatelessWidget {
  final List<Cita> citas = CitasProvider.getCitas();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: crearAppBar("Citas"),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: citasToCard(citas, context),
        ),
      ),
    );
  }
}

List<Widget> citasToCard(List<Cita> citas, BuildContext context) {
  final DateFormat format = DateFormat('hh:mm a');
  List<Widget> cards = [];
  citas.forEach((element) {
    Card card = Card(
      elevation: 5,
      margin: EdgeInsets.all(20),
      child: Center(
          child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Icon(Icons.access_alarm),
          SizedBox(
            height: 5,
          ),
          Text("Cita con ${element.uidProfesional}"),
          SizedBox(
            height: 10,
          ),
          cardLine(title: "Hora", text: '${format.format(element.dateTime)}'),
          cardLine(
              title: "Fecha",
              text:
                  '${element.dateTime.day}/${element.dateTime.month}/${element.dateTime.year}'),
          cardLine(title: "Costo", text: "\$${element.costo}"),
          SizedBox(
            height: 20,
          )
        ],
      )),
    );
    InkWell inkWell = InkWell(
      splashColor: kAmarillo,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DateDetails(cita: element)));
      },
      child: card,
    );
    cards.add(inkWell);
  });
  return cards;
}
