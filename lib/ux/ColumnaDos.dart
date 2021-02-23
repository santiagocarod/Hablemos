import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import 'package:hablemos/services/providers/citas_provider.dart';
import 'package:hablemos/model/cita.dart';

final List<Cita> citas = CitasProvider.getCitas();
final Cita cita = citas[0];

class ColumnaDos extends StatelessWidget {
  const ColumnaDos({
    Key key,
    @required this.size,
    this.titulo1,
    this.titulo2,
    this.titulo3,
    this.titulo4,
  }) : super(key: key);

  final Size size;
  final String titulo1, titulo2, titulo3, titulo4;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        bottom: 67,
      ),
      //width: size.width * 0.2,
      child: Column(
        children: <Widget>[
          //Construye Boton Citas
          GestureDetector(
            onTap: () {
              PageRouteBuilder(
                  transitionDuration: Duration(seconds: 5),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    return ScaleTransition(
                      alignment: Alignment.center,
                      scale: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    Navigator.pushNamed(context, 'citasPaciente');
                  });
            },
            child: Stack(children: [
              Container(
                width: 146,
                height: 128,
                padding: EdgeInsets.only(
                  left: 5,
                  right: 5,
                  top: 75,
                ),
                decoration: BoxDecoration(
                  color: kBlanco,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 5,
                        color: Colors.grey.withOpacity(0.5)),
                  ],
                ),
                child: Center(
                  child: Row(
                    children: [
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Text(
                          '$titulo1',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                child: Icon(
                  Icons.calendar_today_outlined,
                  size: 70,
                  color: kRojoOscuro,
                ),
                top: 10,
                left: 40,
              ),
            ]),
          ),
          //Construye Boton Quiero un Momento
          GestureDetector(
            onTap: () {},
            child: new Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: 30,
                  ),
                  width: 146,
                  height: 196,
                  padding: EdgeInsets.only(
                    top: 30,
                  ),
                  decoration: BoxDecoration(
                    color: kBlanco,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 5,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Stack(
                          children: <Widget>[
                            Container(
                              child: Icon(
                                Icons.favorite_border_outlined,
                                size: 80,
                                color: kVerdeClaro,
                              ),
                              margin: EdgeInsets.only(bottom: 15),
                            ),
                          ],
                        ),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Text(
                            '$titulo2',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //Construye Boton Que hay pa Hacer
          GestureDetector(
            onTap: () {},
            child: new Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: 30,
                  ),
                  width: 146,
                  height: 128,
                  padding: EdgeInsets.only(
                    top: 2,
                  ),
                  decoration: BoxDecoration(
                    color: kBlanco,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 5,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          child: Icon(
                            Icons.people_outline_outlined,
                            size: 70,
                            color: kMorado,
                          ),
                          //margin: EdgeInsets.only(bottom: 1),
                        ),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Text(
                            '$titulo3',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //Construye Boton Mi Cuenta
          GestureDetector(
            onTap: () {},
            child: new Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: 30,
                  ),
                  width: 146,
                  height: 128,
                  padding: EdgeInsets.only(
                    top: 20,
                  ),
                  decoration: BoxDecoration(
                    color: kBlanco,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 5,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          child: Icon(
                            Icons.account_circle_outlined,
                            size: 70,
                            color: kMostaza,
                          ),
                          //margin: EdgeInsets.only(bottom: 1),
                        ),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Text(
                            '$titulo4',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
