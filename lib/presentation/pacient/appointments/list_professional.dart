import 'dart:core';

import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/ux/atoms.dart';

class ListProfessional extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Profesional> profesionales = ModalRoute.of(context).settings.arguments;
    return Stack(
      children: [
        Container(
          //Background Image
          child: Image.asset(
            'assets/images/dateBack.png',
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
            appBar:
                crearAppBar("Profesionales", null, 0, null, context: context),
            body: Stack(
              children: <Widget>[
                // Contents
                Material(
                  type: MaterialType.transparency,
                  child: Padding(
                    padding: EdgeInsets.only(top: 80.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: profToCard(context, profesionales),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> profToCard(
      BuildContext context, List<Profesional> profesionales) {
    List<Widget> cards = [];
    profesionales.forEach((element) {
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
                  '${element.nombre + " " + element.apellido}',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'PoppinsBold',
                  ),
                ),
                subtitle: Text(
                  '${element.experiencia}',
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
                child: '${element.foto}' == "null"
                    ? Icon(
                        Icons.account_circle,
                        color: Colors.indigo[100],
                        size: 200.0,
                      )
                    : Image.network(
                        '${element.foto}', //Foto del profesional
                        height: 250,
                        fit: BoxFit.fill,
                      ),
              ),
              // Especialty below the picture
              ListTile(
                title: Text(
                  '${element.especialidad}',
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
          Navigator.pushNamed(context, 'professionalDetails',
              arguments: element);
        },
        child: card,
      );
      cards.add(inkWell);
    });
    return cards;
  }
}
