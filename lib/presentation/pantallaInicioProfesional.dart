import 'package:flutter/material.dart';
import 'package:hablemos/presentation/bodyProfesional.dart';

import '../constants.dart';
import 'bodyProfesional.dart';
import 'package:hablemos/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

///Pantalla principal del Profesional
///
///En donde se le muestran todas las opciones que puede realizar con la aplicación.
class PantallaInicioProfesional extends StatefulWidget {
  @override
  _PantallaInicioProfesionalState createState() =>
      _PantallaInicioProfesionalState();
}

class _PantallaInicioProfesionalState extends State<PantallaInicioProfesional> {
  String username;
  AuthService _authService = new AuthService();

  ///Cuando se inica la pantalla se obtiene el nombre de la colección "users"
  @override
  void initState() {
    super.initState();
    _authService.getCurrentUser().then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(value.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          setState(() {
            username = documentSnapshot.get("name");
          });
        }
      });
    });
  }

  /// Metodo que crea un [BodyProfesional()] que se encarga de mostar las opciones
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: kAzulPrincipal,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: buildAppBar(size),
          backgroundColor: Colors.transparent,
          body: BodyProfesional(
            size: size,
            username: username,
          ),
        ),
      ),
    );
  }
}

///Construye la barra superior de la aplicación.
AppBar buildAppBar(Size size) {
  return AppBar(
    backgroundColor: kAzulPrincipal,
    elevation: 0,
    toolbarHeight: size.height * 0.001,
    leading: Container(),
  );
}
