import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/model/administrador.dart';
import 'package:hablemos/services/auth.dart';
import 'package:hablemos/util/snapshotConvertes.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/ux/loading_screen.dart';

import '../../../constants.dart';

/// Clase encargada de mostrar el perfil especificamente del administrador
///
/// Solo debe existir un Administrador por esto solo debe traer la información del unico.
class ViewAdminProfile extends StatefulWidget {
  @override
  _ViewAdminProfileState createState() => _ViewAdminProfileState();
}

class _ViewAdminProfileState extends State<ViewAdminProfile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    CollectionReference adminCollection =
        FirebaseFirestore.instance.collection("administrator");

    return StreamBuilder<QuerySnapshot>(
      stream: adminCollection.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('ALGO SALIO MAL');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingScreen();
        }

        List<Administrador> administradores = administradorMapToList(snapshot);
        Administrador admin = administradores[0];

        return Container(
          color: kRosado,
          child: SafeArea(
            bottom: false,
            child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: crearAppBar('', null, 0, null, context: context),
              body: Stack(
                children: <Widget>[
                  adminHead(size, admin),
                  Container(
                    padding: EdgeInsets.only(top: size.height * 0.55),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: _body(size, admin),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Cabecera de la pantalla del perfil
  Widget adminHead(Size size, Administrador admin) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: (size.height / 2) + 50.0,
        width: double.infinity,
        color: kRosado,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height * 0.02,
            ),
            // Plus icon and edit text
            SizedBox(
              height: size.height * 0.01,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 102),
                alignment: Alignment.topCenter,
                child: Text(
                  admin.nombre + " " + admin.apellido,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kNegro,
                    fontSize: (size.height / 2) * 0.1,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Center(
              child: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  'Administrador',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kRojo,
                    fontSize: (size.height / 2) * 0.06,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Sección del cuerpo de la información del perfil
  Widget _body(Size size, Administrador admin) {
    return Container(
      width: size.width,
      child: Column(
        children: <Widget>[
          _section('Correo', admin.correo),
          _section('Ciudad', admin.ciudad),
          _section('Permisos', admin.permisos),
          _sectionPassword(),
          SizedBox(height: 20),
          Center(
              child: iconButtonSmall(
                  color: kRojoOscuro,
                  function: () {
                    AuthService authService = AuthService();
                    authService.logOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/", (_) => false);
                  },
                  iconData: Icons.logout,
                  text: "Cerrar Sesion")),
          SizedBox(height: 20)
        ],
      ),
    );
  }

  /// En esta sección el administrador puede hacer click sobre el boton de "Cambiar"
  ///
  /// Cuando haga esto el sistema debe enviar un correo al correo inscrito del administrador.
  /// Dentro de este correo podrá actualizar a una contraseña nueva.
  Container _sectionPassword() {
    return Container(
      padding: EdgeInsets.only(right: 15.0, left: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Contraseña',
            style: TextStyle(
              fontSize: 20.0,
              color: kRojoOscuro,
              fontFamily: 'PoppinsRegular',
            ),
            textAlign: TextAlign.left,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '*******',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15.0,
                  color: kNegro,
                  fontFamily: 'PoppinsRegular',
                ),
              ),
              Container(
                width: 109.0,
                height: 29.0,
                child: ElevatedButton(
                  child: Text(
                    'Cambiar',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontFamily: 'PoppinsRegular',
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: kRojoOscuro,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(378.0),
                    ),
                    shadowColor: Colors.black,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                        firebaseAuth.sendPasswordResetEmail(
                            email: firebaseAuth.currentUser.email);
                        return _buildPopupDialog(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 5.0),
            child: Divider(
              color: Colors.black.withOpacity(0.40),
            ),
          ),
        ],
      ),
    );
  }

  /// Seccion general para mostrar información del perfil
  ///
  /// Esta informacion va a mostrar tiene un titulo [title] y contenido [content]
  Widget _section(String title, String content) {
    return Container(
      padding: EdgeInsets.only(right: 15.0, left: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              color: kRojoOscuro,
              fontFamily: 'PoppinsRegular',
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            content,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 15.0,
              color: kNegro,
              fontFamily: 'PoppinsRegular',
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5.0),
            child: Divider(
              color: Colors.black.withOpacity(0.40),
            ),
          ),
        ],
      ),
    );
  }
}

/// Dialogo de confirmación de que se ha enviado un correo para cambiar la contraseña
Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: Text('Cambio de Contraseña'),
    content: Text(
      'Hemos enviado las instrucciones de restablecimiento de contraseña a tu correo electrónico.',
      textAlign: TextAlign.justify,
    ),
    actions: <Widget>[
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(
          primary: kRojoOscuro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(378.0),
          ),
          shadowColor: Colors.black,
        ),
        child: const Text('Cerrar'),
      ),
    ],
  );
}
