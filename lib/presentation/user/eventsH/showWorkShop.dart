import 'package:flutter/material.dart';
import 'package:hablemos/model/taller.dart';
import 'package:hablemos/ux/atoms.dart';

import '../../../constants.dart';

class ShowWorkShop extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Taller taller = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBar(taller.titulo, null, 0, null),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height * 0.15,
            ),
            Center(
              child: Container(
                width: 272.0,
                height: 196.0,
                decoration: BoxDecoration(
                  image: taller.foto,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 7.0,
                        color: Colors.grey.withOpacity(0.5)),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Column(
              children: <Widget>[
                Container(
                  width: 330.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Descripción",
                          style: TextStyle(
                              fontFamily: "PoppinsRegular",
                              color: kMoradoOscuro,
                              fontSize: 20.0),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "${taller.descripcion}",
                          style: TextStyle(
                              fontFamily: "PoppinsRegular",
                              color: kLetras,
                              fontSize: 17.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          height: 1.0,
                          color: kGris,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 330.5,
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Horario",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: "PoppinsRegular",
                              color: kMoradoOscuro,
                              fontSize: 20.0),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Row(children: <Widget>[
                              Icon(
                                Icons.calendar_today_outlined,
                                color: kNegro,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${taller.fecha}",
                                style: TextStyle(
                                    fontFamily: "PoppinsRegular",
                                    color: kLetras,
                                    fontSize: 17.0),
                              ),
                            ]),
                          ),
                          Container(
                            child: Row(children: <Widget>[
                              Icon(
                                Icons.access_time_outlined,
                                color: kNegro,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${taller.fecha}",
                                style: TextStyle(
                                    fontFamily: "PoppinsRegular",
                                    color: kLetras,
                                    fontSize: 17.0),
                              ),
                            ]),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          height: 1.0,
                          color: kGris,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 330.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 133.5,
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Costo",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontFamily: "PoppinsRegular",
                                    color: kMoradoOscuro,
                                    fontSize: 20.0),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "${taller.valor}",
                                style: TextStyle(
                                    fontFamily: "PoppinsRegular",
                                    color: kLetras,
                                    fontSize: 17.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                height: 1.0,
                                color: kGris,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 133.5,
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Sesiones",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontFamily: "PoppinsRegular",
                                    color: kMoradoOscuro,
                                    fontSize: 20.0),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "${taller.numeroSesiones}",
                                style: TextStyle(
                                    fontFamily: "PoppinsRegular",
                                    color: kLetras,
                                    fontSize: 17.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                height: 1.0,
                                color: kGris,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 330.5,
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Ubicación",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: "PoppinsRegular",
                              color: kMoradoOscuro,
                              fontSize: 20.0),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${taller.ubicacion}",
                              style: TextStyle(
                                  fontFamily: "PoppinsRegular",
                                  color: kLetras,
                                  fontSize: 17.0),
                            ),
                          ),
                          Icon(Icons.location_on, size: 26.0)
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          height: 1.0,
                          color: kGris,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  width: 296.0,
                  height: 55.0,
                  decoration: BoxDecoration(
                    color: kMoradoClaro,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 7.0,
                          color: Colors.grey.withOpacity(0.5)),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "INSCRIBIRME",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kNegro,
                        fontSize: 20.0,
                        fontFamily: 'PoppinsSemiBold',
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
