import 'package:flutter/material.dart';
import 'package:hablemos/business/negocioOlvideContrasena.dart';
import 'package:hablemos/ux/atoms.dart';

import '../inh_widget.dart';

///Pantalla en donde el usuario ha manifestado que olvidó su contraseña
///
///El usuario pone su correo dentro de un recuadro de texto y oprime el botón
///El botón le pide a Firebase enviar un correo de recuperación
class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController emailController =
        TextEditingController(text: ModalRoute.of(context).settings.arguments);
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
            appBar: crearAppBar('¿Olvidaste tu Contraseña?', null, 0, null,
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
                          _forgotPassword(context, emailController),
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

  ///Metodo encargado de recibir el evento de oprimir el botón y enviar la información
  ///
  ///Cuando se oprime el botón se verifica que el correo sea válido.
  ///Se llama al metodo [olvideMiContrasena()] quien se encarga de enviar el correo.
  ///En caso de que el correo no exista retonra un vacio y muestra un mensaje en pantalla.
  Widget _forgotPassword(
      BuildContext context, TextEditingController emailController) {
    final bloc = InhWidget.of(context);
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          emailTextBox(bloc),
          SizedBox(height: 20),
          iconButtonBig("Enviar Correo", () {
            String email = bloc.email;
            bool valido = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(email);
            if (valido) {
              olvideMiContrasena(email).then((value) {
                if (value) {
                  showAlertDialog(context,
                      "Revisa tu correo, te mandamos un link para recuperar tu contraseña 🎉.",
                      ruta: "login", titulo: "Exito");
                } else {
                  showAlertDialog(context,
                      "No hemos encontrado tu correo😔\nPor favor verifica que este sea correcto.");
                }
              });
            } else {
              showAlertDialog(context, "Por favor, ingresa un correo valido.");
            }
          }, Icons.mark_email_unread, Colors.yellow[700])
        ],
      ),
    );
  }
}
