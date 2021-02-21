import 'package:flutter/material.dart';
import 'package:hablemos/inh_widget.dart';

import '../ux/atoms.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: crearAppBar('Inicio de Sesión'),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          //background aquii
          _centerLogin(context),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

Widget _centerLogin(BuildContext context) {
  final bloc = InhWidget.of(context);

  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        emailTextBox(bloc),
        SizedBox(height: 40.0),
        passwordTextBox(bloc),
        SizedBox(height: 70.0),
        iconButtonBig(
            "Iniciar Sesión",
            () => {Navigator.pushNamed(context, 'inicio')},
            Icons.login,
            Colors.yellow[700],
            bloc),
        SizedBox(height: 20.0),
        GestureDetector(
          onTap: () => {print("haisd")},
          child: Text("¿Olvidaste tu Contraseña?"),
        ),
        SizedBox(height: 20.0),
        textoFinalRojo("Que nada ni nadie empañe tu día, aprovéchalo"),
      ],
    ),
  );
}
