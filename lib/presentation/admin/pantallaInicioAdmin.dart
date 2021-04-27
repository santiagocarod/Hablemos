import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PantallaInicioAdmin extends StatefulWidget {
  @override
  _PantallaInicioAdminState createState() => _PantallaInicioAdminState();
}

class _PantallaInicioAdminState extends State<PantallaInicioAdmin> {
  String username;
  AuthService _authService = new AuthService();

  @override
  void initState() {
    super.initState();
    _authService.getCurrentUser().then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(value.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          setState(() {
            username = documentSnapshot.get("name");
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/pantallaInicio.png',
              alignment: Alignment.center,
              fit: BoxFit.fill,
              width: size.width,
              height: size.height,
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: size.width * 0.9,
                    padding: EdgeInsets.only(top: size.height * 0.07),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'adminViewProfile');
                          },
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.account_circle_rounded),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  "Mi Perfil",
                                  style: TextStyle(
                                      fontFamily: "PoppinSemiBold",
                                      fontSize: 18.0,
                                      color: kNegro),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Log Out",
                            style: TextStyle(
                                fontFamily: "PoppinSemiBold",
                                fontSize: 18.0,
                                color: kNegro),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Container(
                    child: Text(
                      "!Bienvenido, Administrado!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "PoppinSemiBold", fontSize: 30.0),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          _bigButton(
                              context,
                              "Profesionales",
                              "assets/images/iconProfessionals.png",
                              15.0,
                              26.0,
                              "adminManageProffessional"),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          _smallButton(
                              context,
                              "Pagos",
                              "assets/images/paymentIcon.png",
                              21,
                              "inicioAdministrador"),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          _smallButton(
                              context,
                              "Eventos",
                              "assets/images/eventsIcon.png",
                              21,
                              "eventosAdministrador"),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          _bigButton(
                              context,
                              "Líneas de Atención",
                              "assets/images/lineasIcon.png",
                              5.0,
                              15.0,
                              "inicioAdministrador"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  _smallButton(context, "Salud Mental",
                      "assets/images/infoIcon.png", 19, "mainInformation"),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _smallButton(BuildContext context, String titulo, String icon,
    double letra, String routeName) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, routeName);
    },
    child: Container(
      width: 146.0,
      height: 128.0,
      decoration: BoxDecoration(
        color: kBlanco,
        borderRadius: BorderRadius.circular(17.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 7,
            color: Colors.grey.withOpacity(0.6),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 11.0, bottom: 5.0),
            height: 77.67,
            width: 85.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("$icon"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            "$titulo",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "PoppinsRegular", fontSize: 19.0),
          ),
        ],
      ),
    ),
  );
}

Widget _bigButton(BuildContext context, String titulo, String icon,
    double bottom, double top, String routeName) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, routeName);
    },
    child: Container(
      width: 146.0,
      height: 196.0,
      decoration: BoxDecoration(
        color: kBlanco,
        borderRadius: BorderRadius.circular(17.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 7,
            color: Colors.grey.withOpacity(0.6),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: top, bottom: bottom),
            height: 109.0,
            width: 93.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("$icon"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            "$titulo",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "PoppinsRegular", fontSize: 19.0),
          ),
        ],
      ),
    ),
  );
}
