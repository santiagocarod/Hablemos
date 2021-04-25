import 'package:flutter/material.dart';
import 'package:hablemos/ux/atoms.dart';

import '../../../constants.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: crearAppBar('', null, 0, null),
        body: Stack(
          children: <Widget>[
            _background(size),
            _appBar(size),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                alignment: Alignment.center,
                width: size.width,
                // Display two options
                child: Column(
                  children: <Widget>[
                    SizedBox(height: size.height * 0.15),
                    // Button Health Information
                    _button(
                      context,
                      "assets/images/monitorIcon.png",
                      "Información Sobre\nSalud Mental",
                      size,
                      'mainInformation',
                    ),
                    SizedBox(height: size.height * 0.07),
                    // Button Forums
                    _button(
                      context,
                      "assets/images/forumsIcon.png",
                      "Foros de la Comunidad\nProfesional",
                      size,
                      'mainForums',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Display Backgorund
Widget _background(Size size) {
  return Image.asset(
    'assets/images/purpleBackground.png',
    alignment: Alignment.center,
    fit: BoxFit.fill,
    width: size.width,
    height: size.height,
  );
}

// Display Appbar
Widget _appBar(Size size) {
  return Center(
    child: Container(
      padding: EdgeInsets.only(top: size.height * 0.05, bottom: 10.0),
      child: Column(
        children: <Widget>[
          Text(
            'Salud Mental',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PoppinsRegular',
              fontSize: 21.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _button(
    BuildContext context, String icon, String text, Size size, String route) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, route);
    },
    child: Container(
      width: 295.5,
      height: 255.96,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: kMoradoClarito,
        borderRadius: BorderRadius.all(Radius.circular(41)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 7.0,
            color: Colors.grey.withOpacity(0.5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 225.5,
            height: 128.25,
            decoration: BoxDecoration(
              color: kBlanco,
              borderRadius: BorderRadius.circular(81.0),
            ),
            child: Image.asset(
              icon,
            ),
          ),
          Text(
            text,
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
    ),
  );
}
