import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/services/auth.dart';

import '../ux/Encabezado.dart';

///Pantalla principal de usuario no ingresado
///
///Desde esta pantalla el usuario puede crear una cuenta o iniciar sesión con cualquiera de los roles.
class StartFireBase extends StatelessWidget {
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kAzulPrincipal,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          body: FutureBuilder(
            future: _firebaseApp,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Algo salio Mal");
              } else if (snapshot.hasData) {
                return HomeScreen();
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

///Método que se encarga de revisar si el usuario ya inicio sesión
///
///En caso de que ya haya iniciado sesión lo redirige a su pantalla de inicio correspondiente.
///En caso contrario muestra la pantalla principal de usuario general.
///Permite ver informacón general, registrarse [SignInPage()] e iniciar sesion [LoginPage()]
class HomeScreen extends StatelessWidget {
  final AuthService _authService = new AuthService();

  @override
  Widget build(BuildContext context) {
    _authService.getCurrentUser().then((value) {
      if (value != null) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(value.uid)
            .get()
            .then((DocumentSnapshot snapshot) {
          if (snapshot.exists) {
            String role = snapshot.get('role');
            if (role.contains('pacient')) {
              if (value.emailVerified) {
                Navigator.pushNamed(context, 'inicio');
              } else {
                Navigator.pushNamed(context, "verifyEmail");
              }
            } else if (role.contains('professional')) {
              Navigator.pushNamed(context, 'inicioProfesional');
            } else if (role.contains('administrator')) {
              Navigator.pushNamed(context, 'inicioAdministrador');
            }
          }
        });
      }
    });
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      color: kAzulPrincipal,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          backgroundColor: kAzulPrincipal,
          appBar: _appBar(context, size),
          body: Stack(
            children: <Widget>[
              _background(context, size),
              _content(context, size),
            ],
          ),
          bottomNavigationBar: Container(
            width: size.width,
            height: 77.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buttonLogIn(context, size),
                _buttonSignIn(context, size),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///Cabecera de la pantalla
Widget _appBar(BuildContext context, Size size) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: kAzulPrincipal,
    toolbarHeight: size.height * 0.18,
    shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(100),
      bottomRight: Radius.circular(100),
    )),
    flexibleSpace: Column(
      children: [
        EncabezadoHablemos(
          size: size,
          text1: "",
        ),
      ],
    ),
    elevation: 0,
  );
}

///Cuerpo e información
Widget _content(BuildContext context, Size size) {
  return Container(
    padding: EdgeInsets.only(top: 130.0),
    alignment: Alignment.center,
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buttonNecesitoAyuda(context, size),
                  _buttonCartas(context, size),
                  _buttonInformacion(context, size),
                  SizedBox(height: 10.0),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buttonEventos(context, size),
                  _buttonActividades(context, size),
                  _buttonRedes(context, size),
                  SizedBox(height: 10.0),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

///Imagen de fondo
Widget _background(BuildContext context, Size size) {
  return Image.asset(
    "assets/images/pantallaInicio.png",
    alignment: Alignment.center,
    height: size.height,
    width: size.width,
    fit: BoxFit.fill,
  );
}

/// Boton "Necesito Ayuda"
Widget _buttonNecesitoAyuda(BuildContext context, Size size) {
  return Container(
    width: 146.0,
    height: 196.0,
    child: FloatingActionButton(
      heroTag: 'btn1',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.perm_phone_msg_rounded,
            size: 100,
            color: const Color(0xffe45865),
          ),
          SizedBox(height: 15.0),
          Text(
            "Necesito \nAyuda",
            style: TextStyle(
              fontSize: 18,
              color: const Color(0xff302b2b),
              height: 1.1111111111111112,
              fontFamily: 'PoppinsRegular',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17.0),
      ),
      backgroundColor: Colors.white,
      onPressed: () {
        Navigator.pushNamed(context, 'principalCentrosMedicos');
      },
    ),
  );
}

///Botón de eventos
Widget _buttonEventos(BuildContext context, Size size) {
  return Container(
    width: 146.0,
    height: 128.0,
    child: FloatingActionButton(
      heroTag: 'btn2',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.people_alt_rounded,
            size: 78.67,
            color: const Color(0xffC08EF2),
          ),
          Text(
            "¿Qué hay \npa´ hacer?",
            style: TextStyle(
              fontSize: 17,
              color: const Color(0xff302b2b),
              height: 1.1111111111111112,
              fontFamily: 'PoppinsRegular',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17.0),
      ),
      backgroundColor: Colors.white,
      onPressed: () {
        Navigator.pushNamed(context, 'eventosPrincipal');
      },
    ),
  );
}

/// Botón de Cartas
Widget _buttonCartas(BuildContext context, Size size) {
  return Container(
    padding: EdgeInsets.only(top: 20.0),
    width: 146.0,
    height: 128.0,
    child: FloatingActionButton(
      heroTag: 'btn3',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.send_rounded,
            size: 63.68,
            color: const Color(0xffFCD06B),
          ),
          Text(
            "Cartas",
            style: TextStyle(
              fontSize: 18,
              color: const Color(0xff302b2b),
              height: 1.1111111111111112,
              fontFamily: 'PoppinsRegular',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17.0),
      ),
      backgroundColor: Colors.white,
      onPressed: () {
        Navigator.pushNamed(context, "listaCartasPaciente");
      },
    ),
  );
}

/// Botón de Actividades
Widget _buttonActividades(BuildContext context, Size size) {
  return Container(
    padding: EdgeInsets.only(top: 20.0),
    width: 146.0,
    height: 196.0,
    child: FloatingActionButton(
      heroTag: 'btn4',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.favorite_border_rounded,
            size: 84.04,
            color: const Color(0xffA5DF6E),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            "Quiero un \nmomento",
            style: TextStyle(
              fontSize: 18,
              color: const Color(0xff302b2b),
              height: 1.1111111111111112,
              fontFamily: 'PoppinsRegular',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17.0),
      ),
      backgroundColor: Colors.white,
      onPressed: () {
        Navigator.pushNamed(context, 'OpcionesEjercicios');
      },
    ),
  );
}

/// Botón de redes
Widget _buttonRedes(BuildContext context, Size size) {
  return Container(
    padding: EdgeInsets.only(top: 20.0),
    width: 146.0,
    height: 128.0,
    child: FloatingActionButton(
      heroTag: 'btn5',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 2.0,
          ),
          Icon(
            Icons.tablet_mac_rounded,
            size: 73.0,
            color: const Color(0xffFFD4C4),
          ),
          SizedBox(height: 5.0),
          Text(
            "Redes",
            style: TextStyle(
              fontSize: 20,
              color: const Color(0xff302b2b),
              height: 1.1111111111111112,
              fontFamily: 'PoppinsRegular',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17.0),
      ),
      backgroundColor: Colors.white,
      onPressed: () {
        Navigator.pushNamed(context, 'redes');
      },
    ),
  );
}

/// Botón información
Widget _buttonInformacion(BuildContext context, Size size) {
  return Container(
    padding: EdgeInsets.only(top: 20.0),
    width: 146.0,
    height: 128.0,
    child: FloatingActionButton(
      heroTag: 'btn6',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 3.0),
          Icon(
            Icons.message_rounded,
            size: 73.0,
            color: const Color(0xff46D4E1),
          ),
          SizedBox(height: 5.0),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Text(
              "Información",
              style: TextStyle(
                fontSize: 18,
                color: const Color(0xff302b2b),
                height: 1.1111111111111112,
                fontFamily: 'PoppinsRegular',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17.0),
      ),
      backgroundColor: Colors.white,
      onPressed: () {
        Navigator.pushNamed(context, 'Informacion');
      },
    ),
  );
}

/// Botón que redirecciona a la pantalla de iniciar sesión
Widget _buttonLogIn(BuildContext context, Size size) {
  return Container(
    //padding: EdgeInsets.only(top: 20.0),
    width: size.width / 2,
    height: 77.0,
    child: FloatingActionButton(
      heroTag: 'btn7',
      child: Text(
        "Iniciar Sesión",
        style: TextStyle(
          fontSize: 22,
          color: const Color(0xffE45865),
          height: 1.1111111111111112,
          fontFamily: 'PoppinsRegular',
        ),
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      backgroundColor: const Color(0xffFCD06B),
      onPressed: () {
        Navigator.pushNamed(context, 'login');
      },
    ),
  );
}

/// Botón que redirecciona a la pantalla de registro
Widget _buttonSignIn(BuildContext context, Size size) {
  return Container(
    //padding: EdgeInsets.only(top: 20.0),
    width: size.width / 2,
    height: 77.0,
    child: FloatingActionButton(
      heroTag: 'btn8',
      child: Text(
        "Registrarme",
        style: TextStyle(
          fontSize: 22,
          color: const Color(0xff202830),
          height: 1.1111111111111112,
          fontFamily: 'PoppinsRegular',
        ),
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      backgroundColor: const Color(0xffFCD06B),
      onPressed: () {
        Navigator.pushNamed(context, 'registro');
      },
    ),
  );
}
