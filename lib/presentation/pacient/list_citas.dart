import 'package:flutter/material.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/services/providers/citas_provider.dart';
import 'package:hablemos/ux/atoms.dart';

class ListCitas extends StatelessWidget {
  final List<Cita> citas = CitasProvider.getCitas();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: crearAppBar("Citas"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: citasToCard(citas),
        ),
      ),
    );
  }
}

List<Widget> citasToCard(List<Cita> citas) {
  List<Widget> cards = [];

  citas.forEach((element) {
    Card card = Card(
      child: Center(
          child: Column(
        children: [
          Text(element.uidPaciente),
          SizedBox(
            height: 10,
          ),
          Text(element.uidProfesional),
        ],
      )),
    );
    cards.add(card);
  });
  return cards;
}
