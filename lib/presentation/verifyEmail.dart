import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:timer_button/timer_button.dart';

import '../constants.dart';

class VerifyEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String correo = ModalRoute.of(context).settings.arguments;
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
            appBar: crearAppBar('Correo de Confirmación', null, 0, null,
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
                          _verifyEmail(context, correo),
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

  Widget _verifyEmail(BuildContext context, String correo) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
                "Hemos enviado un correo a:\n\n$correo\n\nRevisa tu correo y confirma tu cuenta.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: kLetras,
                    fontSize: 28,
                    fontFamily: "PoppinsRegular")),
          ),
          SizedBox(height: 20),
          iconButtonBig("¡ LISTO !", () {
            Navigator.pushNamed(context, "login");
          }, Icons.login, Colors.yellow[700]),
          SizedBox(height: 20),
          TimerButton(
            label: "Enviar Nuevamente",
            onPressed: () {
              FirebaseAuth firebaseAuth = FirebaseAuth.instance;
              firebaseAuth.currentUser.sendEmailVerification().then((value) =>
                  showAlertDialog(context, "Correo enviado 📤.",
                      titulo: "¡Listo!"));
            },
            timeOutInSeconds: 60,
            disabledColor: Colors.red,
            color: Colors.yellow[700],
            activeTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: "PoppinsRegular"),
            disabledTextStyle: TextStyle(
                color: kLetras, fontSize: 20, fontFamily: "PoppinsRegular"),
            buttonType: ButtonType.RaisedButton,
          )
        ],
      ),
    );
  }
}
