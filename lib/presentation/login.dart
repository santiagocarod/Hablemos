import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/inh_widget.dart';
import 'package:hablemos/services/auth.dart';

import '../ux/atoms.dart';

///Pantalla que permite al usuario iniciar sesión
///
///Recibe la información de correo y contraseña, la envia a firebase que revisa su veracidad.
///En caso de que sean correctas redirecciona a la pantalla principal de cada Rol.
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

///Campos encargados de recibir la información
///
///Además tiene los botones de iniciar sesion que llama a [loginLogic()].
///Y el de olvide mi contraseña que redirige a [ForgotPassword()]
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

///Método encargado de la enviar la información a la lógica de iniciar sesión.
///
///En caso de que al lógica retorne un `null` significa que las credenciales estan mal.
///La lógica del incio de sesión esta en [AuthService.logIn()]
loginLogic(dynamic bloc, BuildContext context) {
  AuthService authService = new AuthService();
  Future<User> user = authService.logIn(bloc.email, bloc.password);
  user.then((value) {
    if (value == null) {
      showAlertDialog(
          context, "Hubo un Error 😔\nRevisa tu usuario y contraseña.");
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
