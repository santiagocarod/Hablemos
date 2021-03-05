import 'package:flutter/material.dart';
import 'package:hablemos/model/paciente.dart';
import 'package:hablemos/services/providers/pacientes_provider.dart';
import '../constants.dart';
import 'body.dart';
import 'package:hablemos/services/auth.dart';

class PantallaInicio extends StatefulWidget {
  @override
  _PantallaInicioState createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  String username;
  AuthService _authService = new AuthService();

  @override
  void initState() {
    super.initState();
    _authService.getCurrentUser().then((value) {
      setState(() {
        username = value.email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Paciente paciente = PacientesProvider.getPaciente();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: buildAppBar(size),
        backgroundColor: Colors.transparent,
        body: Body(
          size: size,

          username: username,
        ));
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
