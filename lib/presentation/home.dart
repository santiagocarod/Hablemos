import 'package:flutter/material.dart';

import '../inh_widget.dart';

// Screen of user that wants to register or login ==============================
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bloc = InhWidget.of(context);
    bloc.changeEmail('');
    bloc.changePassword('');
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appBar(context, size),
      body: _content(context, size),
    );
  }
}

// Header of screen, image with title ==================================
Widget _appBar(BuildContext context, Size size) {
  return PreferredSize(
    preferredSize: Size.fromHeight(165.0),
    child: AppBar(
      leading: Container(),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: const Radius.circular(100.0),
          bottomRight: const Radius.circular(100.0),
        ),
      ),
      flexibleSpace: Image(
        fit: BoxFit.none,
        height: size.height,
        width: size.width,
        image: AssetImage("assets/images/appBar.png"),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),
  );
}

// Body of the screen ==================================================
Widget _content(BuildContext context, Size size) {
  return SingleChildScrollView(
    child: Stack(
      children: <Widget>[
        _background2(context, size),
        _button7(context, size),
        _button8(context, size),
        Column(
          children: <Widget>[
            _button1(context, size),
            _button2(context, size),
            _button3(context, size),
            _button4(context, size),
            _button5(context, size),
            _button6(context, size),
          ],
        ),
      ],
    ),
  );
}

// Background image ================================================
Widget _background2(BuildContext context, Size size) {
  return Image(
    height: size.height,
    width: size.width,
    image: AssetImage("assets/images/background.png"),
    fit: BoxFit.cover,
  );
}

// Button of "Necesito Ayuda" ======================================
Widget _button1(BuildContext context, Size size) {
  return Transform.translate(
    offset: Offset((size.width / 2) - 163.0, 235.1),
    child: SizedBox(
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
    ),
  );
}

// Button of "Qué hay pa hacer" ====================================
Widget _button2(BuildContext context, Size size) {
  return Transform.translate(
    offset: Offset((size.width / 2) + 20.0, 38.0),
    child: SizedBox(
      width: 146.0,
      height: 140.0,
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
    ),
  );
}

// Button of "Cartas" ==============================================
Widget _button3(BuildContext context, Size size) {
  return Transform.translate(
    offset: Offset((size.width / 2) - 163.0, 112.24),
    child: SizedBox(
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
          // Navigator.pushNamed(context, 'cartas');
        },
      ),
    ),
  );
}

// Button of "Quiero un momento" ===================================
Widget _button4(BuildContext context, Size size) {
  return Transform.translate(
    offset: Offset((size.width / 2) + 20.0, -78.0),
    child: SizedBox(
      width: 146.0,
      height: 193.0,
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
          // Navigator.pushNamed(context, 'actividades');
        },
      ),
    ),
  );
}

// Button of "Redes" ===============================================
Widget _button5(BuildContext context, Size size) {
  return Transform.translate(
    offset: Offset((size.width / 2) + 20.0, -58.0),
    child: SizedBox(
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
    ),
  );
}

// Button of "Información" =========================================
Widget _button6(BuildContext context, Size size) {
  return Transform.translate(
    offset: Offset((size.width / 2) - 160.0, -185.24),
    child: SizedBox(
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
    ),
  );
}

// Button of "Iniciar Sesión" ======================================
Widget _button7(BuildContext context, Size size) {
  return Transform.translate(
    offset: Offset(0.0, (size.height / 2) + 360.0),
    child: SizedBox(
      width: 206.0,
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
    ),
  );
}

// Button of "Registrarme" =========================================
Widget _button8(BuildContext context, Size size) {
  return Transform.translate(
    offset: Offset(206.0, (size.height / 2) + 360.0),
    child: SizedBox(
      width: 206.0,
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
          height: 141,
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
            SizedBox(
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
            SizedBox(
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
                  // Navigator.pushNamed(context, 'saludmental');
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
