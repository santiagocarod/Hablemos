import 'package:flutter/material.dart';

import '../ux/atoms.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
            _TopTitleWButton(),
            _CenterLogin(),
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

class _TopTitleWButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
            size: 40,
          ),
          onPressed: () => {},
        ),
        Text(
          "Inicio de Sesión",
          style: TextStyle(fontSize: 25),
        ),
        SizedBox()
      ],
    );
  }
}

class _CenterLogin extends StatelessWidget {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            emailTextBox(emailTextController),
            SizedBox(height: 40.0),
            passwordTextBox(passwordTextController),
            SizedBox(height: 70.0),
            iconButton(
                "Iniciar Sesión",
                () => {print(passwordTextController.text)},
                Icons.login,
                Colors.yellow[700]),
            SizedBox(height: 20.0),
            GestureDetector(
                onTap: () => {print("haisd")},
                child: Text("¿Olvidaste tu Contraseña?"))
          ]),
    );
  }
}
