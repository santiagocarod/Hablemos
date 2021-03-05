import 'package:flutter/material.dart';
import 'package:hablemos/model/paciente.dart';
import 'package:hablemos/services/providers/pacientes_provider.dart';
import '../constants.dart';
import 'body.dart';

class PantallaInicio extends StatelessWidget {
  PantallaInicio({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Paciente paciente = PacientesProvider.getPaciente();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: buildAppBar(size),
        backgroundColor: Colors.transparent,
        body: Body(
          size: size,
          username: paciente.nombre,
        ));
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
}
