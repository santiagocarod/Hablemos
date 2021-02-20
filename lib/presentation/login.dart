import 'package:flutter/material.dart';
import 'package:hablemos/inh_widget.dart';

import '../ux/atoms.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _crearAppBar('Inicio de Sesión'),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          _centerLogin(context),
          textoFinalRojo("Que nada ni nadie empañe tu día, aprovéchalo"),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

AppBar _crearAppBar(String texto) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: Text(
      texto,
      style: TextStyle(
        color: Colors.black,
        fontSize: 25.0,
      ),
    ),
    centerTitle: true,
    iconTheme: IconThemeData(
      color: Colors.black, //change your color here
    ),
  );
}

Widget _centerLogin(BuildContext context) {
  final bloc = InhWidget.of(context);

  return Expanded(
    child:
        Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      emailTextBox(bloc),
      SizedBox(height: 40.0),
      passwordTextBox(bloc),
      SizedBox(height: 70.0),
      iconButton(
          "Iniciar Sesión",
          () => {Navigator.pushNamed(context, 'inicio')},
          Icons.login,
          Colors.yellow[700],
          bloc),
      SizedBox(height: 20.0),
      GestureDetector(
          onTap: () => {print("haisd")},
          child: Text("¿Olvidaste tu Contraseña?"))
    ]),
  );
}
