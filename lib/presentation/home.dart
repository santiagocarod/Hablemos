import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import '../ux/Encabezado.dart';
import 'package:firebase_core/firebase_core.dart';

class StartFireBase extends StatelessWidget {
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _firebaseApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Error: ${snapshot.error.toString()}");
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
    );
  }
}

// Screen of user that wants to register or login ==============================
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
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
              _button7(context, size),
              _button8(context, size),
            ],
          ),
        ),
      ),
    );
  }
}

// Header of screen, image with title ==================================
Widget _appBar(BuildContext context, Size size) {
  return AppBar(
    toolbarHeight: size.height * 0.18,
    leading: Container(),
    shape: ContinuousRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: const Radius.circular(100.0),
        bottomRight: const Radius.circular(100.0),
      ),
    ),
    flexibleSpace: Column(
      children: [
        EncabezadoHablemos(
          size: size,
          text1: "",
        ),
      ],
    ),
    elevation: 0,
    backgroundColor: kAzulPrincipal,
  );
}

// Body of the screen ==================================================
Widget _content(BuildContext context, Size size) {
  return Container(
    padding: EdgeInsets.only(top: 130.0),
    alignment: Alignment.center,
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _button1(context, size),
                  _button3(context, size),
                  _button6(context, size),
                  SizedBox(height: 20.0),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _button2(context, size),
                  _button4(context, size),
                  _button5(context, size),
                  SizedBox(height: 20.0),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// Background image ================================================
Widget _background(BuildContext context, Size size) {
  return Image.asset(
    "assets/images/pantallaInicio.png",
    alignment: Alignment.center,
    height: size.height,
    width: size.width,
    fit: BoxFit.fill,
  );
}

// Button of "Necesito Ayuda" ======================================
Widget _button1(BuildContext context, Size size) {
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
        Navigator.pushNamed(context, 'centrosayuda');
      },
    ),
  );
}

// Button of "Qué hay pa hacer" ====================================
Widget _button2(BuildContext context, Size size) {
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
            "Qué hay \npa´ hacer",
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
        // Navigator.pushNamed(context, 'eventos');
      },
    ),
  );
}

// Button of "Cartas" ==============================================
Widget _button3(BuildContext context, Size size) {
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

// Button of "Quiero un momento" ===================================
Widget _button4(BuildContext context, Size size) {
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

// Button of "Redes" ===============================================
Widget _button5(BuildContext context, Size size) {
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
          Icon(
            Icons.tablet_mac_rounded,
            size: 75.0,
            color: const Color(0xffFFD4C4),
          ),
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
        // Navigator.pushNamed(context, 'redes');
      },
    ),
  );
}

// Button of "Información" =========================================
Widget _button6(BuildContext context, Size size) {
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
          Icon(
            Icons.message_rounded,
            size: 85.67,
            color: const Color(0xff46D4E1),
          ),
          Text(
            "Información",
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
        _settingBottomSheet(context);
      },
    ),
  );
}

// Button of "Iniciar Sesión" ======================================
Widget _button7(BuildContext context, Size size) {
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

// Button of "Registrarme" =========================================
Widget _button8(BuildContext context, Size size) {
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

// Function of the bottom sheet of the "Información" button ====================
void _settingBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          height: 141.44,
          child: _buildItems(context),
        );
      });
}

// Buttons of bottom sheet =====================================================
Widget _buildItems(BuildContext context) {
  return Container(
    // Bottom sheet properties =================================================
    width: 412.0,
    height: 141.44,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(70.0),
        topRight: const Radius.circular(70.0),
      ),
      color: const Color(0xff8EE8D8),
    ),
    // Buttons =================================================================
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // Button of "Foro" ====================================================
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 140.75,
              height: 80.67,
              child: FloatingActionButton(
                heroTag: 'btn9',
                child: Icon(
                  Icons.comment_bank_outlined,
                  size: 84.71,
                  color: const Color(0xff205072),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(81.0),
                ),
                backgroundColor: Colors.white,
                onPressed: () {
                  // Navigator.pushNamed(context, 'foro');
                },
              ),
            ),
            Text(
              "Foro",
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
        // Button of "Salud Mental" ============================================
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 140.75,
              height: 80.67,
              child: FloatingActionButton(
                heroTag: 'btn10',
                child: Icon(
                  Icons.monitor,
                  size: 84.71,
                  color: const Color(0xff205072),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(81.0),
                ),
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, 'Informacion');
                },
              ),
            ),
            Text(
              "Salud Mental",
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
      ],
    ),
  );
}
