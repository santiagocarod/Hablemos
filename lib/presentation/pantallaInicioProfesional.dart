import 'package:flutter/material.dart';
import 'package:hablemos/presentation/bodyProfesional.dart';
/*import 'package:hablemos/model/paciente.dart';
import 'package:hablemos/services/providers/pacientes_provider.dart';*/
import '../constants.dart';
import 'bodyProfesional.dart';
import 'package:hablemos/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PantallaInicioProfesional extends StatefulWidget {
  @override
  _PantallaInicioProfesionalState createState() =>
      _PantallaInicioProfesionalState();
}

class _PantallaInicioProfesionalState extends State<PantallaInicioProfesional> {
  String username;
  AuthService _authService = new AuthService();

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

  @override
  Widget build(BuildContext context) {
    //Paciente paciente = PacientesProvider.getPaciente();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(size),
        backgroundColor: Colors.transparent,
        body: BodyProfesional(
          size: size,
          username: username,
        ),
      ),
    );
  }
}

AppBar buildAppBar(Size size) {
  //EncabezadoHablemos(size: size, text1: "Diana");
  return AppBar(
    backgroundColor: kAzulPrincipal,
    elevation: 0,
    toolbarHeight: size.height * 0.001,
    leading: Container(),
  );
}
