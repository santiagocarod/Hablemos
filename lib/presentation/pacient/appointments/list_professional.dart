import 'dart:core';

import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/ux/atoms.dart';

/// Clase encargada de mostrar la lista de todos los [Profesional]es de la organización para consulta de los pacientes
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

  /// Metodo que convierte cada [Profesional] en una [Card] para ser mostrada al usuario con información básica
  ///
  /// Ademas si se hace Click sobre algun profesional se redirige a [ProfessionalDetails()] para ver la información del perfil ampliada
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'PoppinsBold',
                  ),
                ),
                contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                leading: Icon(Icons.account_circle_rounded,
                    color: Colors.cyan, size: 30.0),
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
                        size: 190.0,
                      )
                    : Image.network(
                        '${element.foto}', //Foto del profesional
                        height: 190,
                        width: 180,
                        fit: BoxFit.contain,
                      ),
              ),
              // Especialty below the picture
              ListTile(
                title: Text(
                  '${element.especialidad}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
                contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
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
