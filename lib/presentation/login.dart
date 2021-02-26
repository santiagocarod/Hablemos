import 'package:flutter/material.dart';
import 'package:hablemos/inh_widget.dart';
import 'package:hablemos/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
          Future<User> user = authService.logIn("santiago@gmail.com", "123456");
          user.then((value) {
            if (value != null) {
              Navigator.pushNamed(context, 'inicio');
            } else {
              print("Usuario y/o Contraseña erroneos");
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
