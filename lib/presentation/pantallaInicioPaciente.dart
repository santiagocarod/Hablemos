import 'package:flutter/material.dart';
/*import 'package:hablemos/model/paciente.dart';
import 'package:hablemos/services/providers/pacientes_provider.dart';*/
import '../constants.dart';
import 'bodyPacient.dart';
import 'package:hablemos/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PantallaInicioPacinete extends StatefulWidget {
  @override
  _PantallaInicioPacineteState createState() => _PantallaInicioPacineteState();
}

class _PantallaInicioPacineteState extends State<PantallaInicioPacinete> {
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
    return Container(
      color: kAzulPrincipal,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: buildAppBar(size),
          backgroundColor: Colors.transparent,
          body: BodyPacient(
            size: size,
            username: username,
          ),
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
