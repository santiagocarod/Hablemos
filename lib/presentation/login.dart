import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/inh_widget.dart';
import 'package:hablemos/services/auth.dart';

import '../ux/atoms.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          child: Image.asset(
            'assets/images/yellowBack.png',
            alignment: Alignment.center,
            fit: BoxFit.fill,
            width: size.width,
            height: size.height,
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: crearAppBar('Inicio de Sesión', null, 0, null,
                context: context),
            body: Stack(
              children: [
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
          ),
        ),
      ],
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
          loginLogic(bloc, context);
        }, Icons.login, Colors.yellow[700], bloc),
        SizedBox(height: 20.0),
        GestureDetector(
          onTap: () => {
            Navigator.pushNamed(context, "olvideConstrasena",
                arguments: bloc.email)
          },
          child: Text("¿Olvidaste tu Contraseña?"),
        ),
        SizedBox(height: 20.0),
        textoFinalRojo("Que nada ni nadie empañe tu día, aprovéchalo"),
      ],
    ),
  );
}

loginLogic(dynamic bloc, BuildContext context) {
  AuthService authService = new AuthService();
  Future<User> user = authService.logIn(bloc.email, bloc.password);
  user.then((value) {
    if (value == null) {
      showAlertDialog(
          context, "Hubo un error😔\nRevisa tu Usuario y Contraseña");
    } else {
      FirebaseFirestore.instance
          .collection('users')
          .doc(value.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          if (documentSnapshot.get('role') == 'pacient') {
            if (value.emailVerified) {
              Navigator.pushNamed(context, 'inicio');
            } else {
              Navigator.pushNamed(context, "verifyEmail",
                  arguments: bloc.email);
            }
          } else if (documentSnapshot.get('role') == 'professional') {
            Navigator.pushNamed(context, 'inicioProfesional');
          } else if (documentSnapshot.get('role') == 'administrator') {
            Navigator.pushNamed(context, 'inicioAdministrador');
          } else {
            Navigator.pushNamed(context, 'inicio');
          }
        }
      });
    }
  });
}
