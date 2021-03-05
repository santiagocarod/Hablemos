import 'package:flutter/material.dart';
import 'package:hablemos/inh_widget.dart';
import 'package:hablemos/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants.dart';
import '../ux/atoms.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBar('Inicio de Sesión', null, 0, null),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/yellowBack.png',
            alignment: Alignment.center,
            fit: BoxFit.fill,
            width: size.width,
            height: size.height,
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.0),
            child: SingleChildScrollView(
              child: Container(
                height: size.height,
                width: double.infinity,
                child: Column(
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
              ),
            ),
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
        iconButtonBigBloc("Iniciar Sesión", () {
          print('${bloc.email} : ${bloc.password}');
          AuthService authService = new AuthService();
          Future<String> user = authService.logIn(bloc.email, bloc.password);
          user.then((value) {
            print("RETORNO" + value);
            if (value[0] == "[") {
              showAlertDialog(context);
            } else {
              Navigator.pushNamed(context, 'inicio');
            }
          });
        }, Icons.login, Colors.yellow[700], bloc),
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

showAlertDialog(BuildContext context) {
  Widget okButton = FloatingActionButton(
    child: Text("OK"),
    backgroundColor: kMostaza,
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text("Hubo un error\nRevisa tu Usuario y Contraseña"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
