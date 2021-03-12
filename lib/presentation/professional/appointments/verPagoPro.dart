import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';

//Screen of attached payment
class VerPagoPro extends StatelessWidget {
  VerPagoPro({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/verPago.png',
            alignment: Alignment.center,
            fit: BoxFit.fill,
            width: size.width,
            height: size.height,
          ),
          Container(
            padding: EdgeInsets.only(
              top: size.height * 0.06,
            ),
            child: Column(
              children: <Widget>[
                _pageHeader(context, size),
                Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(top: size.height * 0.15),
                        height: 270.0,
                        width: 370.0,
                        child: Image.asset('images/ejemploPago.png',
                            height: 270.0, width: 370.0, fit: BoxFit.cover),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'citasProfesional');
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 80),
                          alignment: Alignment.center,
                          width: 159,
                          height: 42,
                          decoration: BoxDecoration(
                            color: kAzulOscuro,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 5,
                                  color: Colors.grey.withOpacity(0.5)),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.control_point,
                                color: kBlanco,
                                size: 20.0,
                              ),
                              Text(
                                'Aceptar Pago',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    color: kBlanco,
                                    decoration: TextDecoration.none),
                              ),
                            ],
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _pageHeader(BuildContext context, Size size) {
  return Container(
    padding: EdgeInsets.only(bottom: size.height * 0.03),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              padding: EdgeInsets.only(left: size.width * 0.05),
              child: Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: Colors.black,
              )),
        ),
        Container(
          child: Container(
            child: Text(
              'Pago Cita',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 22,
                  color: Colors.black,
                  decoration: TextDecoration.none),
            ),
          ),
        ),
        SizedBox(width: size.width * 0.05),
      ],
    ),
  );
}