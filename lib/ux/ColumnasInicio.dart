import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';

class ColumnasInicio extends StatelessWidget {
  const ColumnasInicio({
    Key key,
    @required this.size,
    this.titulo1,
    this.titulo2,
    this.titulo3,
    this.titulo4,
  }) : super(key: key);

  final Size size;
  final String titulo1, titulo2, titulo3, titulo4;
  //final Function press;

  _showExtraScreen(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            height: 150,
            width: 412,
            decoration: BoxDecoration(
              color: kMarino,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60), topRight: Radius.circular(60)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //Construye Boton Foro
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'ForosPaciente');
                        },
                        child: Hero(
                          tag: heroForo,
                          child: Column(
                            children: [
                              Container(
                                width: 140,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: kBlanco,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 0),
                                        blurRadius: 5,
                                        color: Colors.grey.withOpacity(0.5)),
                                  ],
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(top: 3),
                                        child: Icon(
                                          Icons.comment_bank_outlined,
                                          size: 75,
                                          color: kAzulOscuro,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Foro',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //Construye Boton Informacion Salud Mental
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'Informacion');
                        },
                        child: Hero(
                          tag: heroSaludMental,
                          child: Column(
                            children: [
                              Container(
                                width: 140,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: kBlanco,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 0),
                                        blurRadius: 5,
                                        color: Colors.grey.withOpacity(0.5)),
                                  ],
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.monitor,
                                          size: 75,
                                          color: kAzulOscuro,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Salud Mental',
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        bottom: 29,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //Construye Boton Necesito Ayuda
          GestureDetector(
            onTap: () {},
            child: Stack(
              children: [
                Hero(
                  tag: heroCentrosAtencion,
                  child: Container(
                    width: 146,
                    height: 196,
                    padding: EdgeInsets.only(
                      left: 5,
                      right: 5,
                      top: 125,
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
                              '$titulo1\n',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Center(
                    child: Icon(
                      Icons.perm_phone_msg_rounded,
                      size: 85,
                      color: kRojoOscuro,
                    ),
                  ),
                  top: 30,
                  left: 27,
                ),
              ],
            ),
          ),
          //Construye Boton Informacion
          GestureDetector(
            onTap: () {
              _showExtraScreen(context);
            },
            child: new Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                  ),
                  width: 146,
                  height: 128,
                  padding: EdgeInsets.only(
                    top: 10,
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
                            Icons.message_rounded,
                            size: 75,
                            color: kAguaMarina,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Text(
                            '$titulo2\n',
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
          //Construye Boton Cartas
          GestureDetector(
            onTap: () {
              //TODO: Aplicar el Hero para la animación.
              Navigator.pushNamed(context, "listaCartasPaciente");
            },
            child: new Column(
              children: <Widget>[
                Hero(
                  tag: heroCartas,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 20,
                    ),
                    width: 146,
                    height: 128,
                    padding: EdgeInsets.only(
                      top: 10,
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
                              Icons.send_rounded,
                              size: 75,
                              color: kMostaza,
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Text(
                              '$titulo3\n',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //Construye Boton Redes
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'redes');
            },
            child: Hero(
              tag: heroRedes,
              child: new Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 20,
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
                          Container(
                            child: Icon(
                              Icons.smartphone_rounded,
                              color: kAmarillo,
                              size: 100,
                            ),
                            margin: EdgeInsets.only(bottom: 10),
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Text(
                              '$titulo4\n',
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
          ),
        ],
      ),
    );
  }
}
