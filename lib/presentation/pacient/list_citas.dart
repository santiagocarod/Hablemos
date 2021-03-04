import 'package:flutter/material.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/services/providers/citas_provider.dart';
import 'package:hablemos/services/providers/profesionales_provider.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/presentation/pacient/dateDetails.dart';
import 'package:intl/intl.dart';

class ListCitas extends StatelessWidget {
  final List<Cita> citas = CitasProvider.getCitas();
  final Profesional profesional = ProfesionalesProvider.getProfesional();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBar(
          "Citas", Icons.calendar_today_outlined, heroCita, kRojoOscuro),
      body: Stack(
        children: <Widget>[
          //Background Image
          Image.asset(
            'assets/images/dateBack.png',
            alignment: Alignment.center,
            fit: BoxFit.fill,
            width: size.width,
            height: size.height,
          ),
          // Contents
          Padding(
            padding: EdgeInsets.only(top: 100.0),
            child: Material(
              type: MaterialType.transparency,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: citasToCard(citas, profesional, context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> citasToCard(
    List<Cita> citas, Profesional profesional, BuildContext context) {
  final DateFormat format = DateFormat('hh:mm a');
  List<Widget> cards = [];
  citas.forEach((element) {
    Card card = Card(
      elevation: 5,
      margin: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      shadowColor: Colors.black.withOpacity(1.0),
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
          Text(
              'Cita con ${profesional.nombre} ${profesional.apellido}'), //Text("Cita con ${element.uidProfesional}"),
          SizedBox(
            height: 10,
          ),
          secction(title: "Hora", text: '${format.format(element.dateTime)}'),
          secction(
              title: "Fecha",
              text:
                  '${element.dateTime.day}/${element.dateTime.month}/${element.dateTime.year}'),
          secction(title: "Costo", text: "\$${element.costo}"),
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
  // Button
  Container button = Container(
    alignment: Alignment.bottomRight,
    margin: EdgeInsets.all(20),
    child: FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: kRojoOscuro,
      onPressed: () {
        Cita cita;
        Navigator.pushNamed(context, 'CrearCita', arguments: cita);
      },
    ),
  );
  cards.add(button);
  return cards;
}
