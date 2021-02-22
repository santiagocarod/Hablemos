import 'package:flutter/material.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/services/providers/profesionales_provider.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/constants.dart';

class ListProfessional extends StatelessWidget {
  final Profesional profesional = ProfesionalesProvider.getProfesional();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: crearAppBar("Profesionales"),
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
          Material(
            type: MaterialType.transparency,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: profToCard(context, profesional),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> profToCard(BuildContext context, Profesional profesional) {
  List<Widget> cards = [];
  Card card = Card(
    elevation: 5,
    margin: EdgeInsets.all(20),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0))),
    shadowColor: Colors.black.withOpacity(1.0),
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Name, Experience y Miniature above the picture
          ListTile(
            title: Text(
              '${profesional.nombre + " " + profesional.apellido}',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'PoppinsBold',
              ),
            ),
            subtitle: Text(
              '${profesional.experiencia}',
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: 'PoppinsBold',
              ),
            ),
            contentPadding: const EdgeInsets.all(10.0),
            leading: Icon(Icons.account_circle_rounded,
                color: Colors.cyan, size: 50.0),
          ),
          // Central Picture
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
            child: Image.network(
              'https://picsum.photos/250?image=9', //Foto del profesional
              height: 250,
              fit: BoxFit.fill,
            ),
          ),
          // Especialty below the picture
          ListTile(
            title: Text(
              '${profesional.especialidades}',
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: 'PoppinsRegular',
              ),
            ),
          ),
        ],
      ),
    ),
  );
  InkWell inkWell = InkWell(
    splashColor: kAmarillo,
    onTap: () {
      //Colocar Detalles Profesional
    },
    child: card,
  );
  cards.add(inkWell);
  return cards;
}
