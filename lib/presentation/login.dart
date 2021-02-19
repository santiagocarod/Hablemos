import 'package:flutter/material.dart';
import 'package:hablemos/inh_widget.dart';

import '../ux/atoms.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            _topTitleWButton(context),
            _centerLogin(context),
            DecoratedBox(
              child: Text('"Que nada ni nadie empañe tu día, aprovéchalo"'),
              decoration: BoxDecoration(color: Colors.blue[100]),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _topTitleWButton(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconButton(
        icon: Icon(
          Icons.keyboard_backspace,
          size: 40,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      Text(
        "Inicio de Sesión",
        style: TextStyle(fontSize: 25),
      ),
      SizedBox()
    ],
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
