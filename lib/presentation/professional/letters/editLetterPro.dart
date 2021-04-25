import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/carta.dart';
import 'package:hablemos/ux/atoms.dart';

class EditLetterPro extends StatelessWidget {
  final TextEditingController tituloCarta = TextEditingController();
  final TextEditingController contenidoCarta = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Carta carta = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: crearAppBar("Editar Carta", null, 0, null),
        body: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/lettersBackground.png',
              alignment: Alignment.center,
              fit: BoxFit.fill,
              width: size.width,
              height: size.height,
            ),
            Material(
              type: MaterialType.transparency,
              child: Padding(
                padding: EdgeInsets.only(top: 120.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.1),
                          child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.name,
                            controller: TextEditingController()
                              ..text = carta.titulo,
                            decoration: InputDecoration(
                              labelText: "Titulo",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintStyle: TextStyle(
                                  fontFamily: 'PoppinsRegular',
                                  fontSize: 18,
                                  color: kLetras),
                              fillColor: kLetras,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.1,
                              vertical: size.height * 0.05),
                          child: Center(
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              minLines: 20,
                              maxLines: 50,
                              controller: TextEditingController()
                                ..text = carta.cuerpo,
                              decoration: InputDecoration(
                                labelText: "Carta",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintStyle: TextStyle(
                                    fontFamily: 'PoppinsRegular',
                                    fontSize: 16,
                                    color: kLetras),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: kAzulClaro),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "valorarCartaPro");
                          },
                          child: Container(
                            width: 239.0,
                            height: 43.0,
                            margin: EdgeInsets.only(bottom: size.height * 0.04),
                            decoration: BoxDecoration(
                              color: kRojoOscuro,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 0),
                                    blurRadius: 5,
                                    color: Colors.grey.withOpacity(0.5)),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                "GUARDAR",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kNegro,
                                  fontSize: 18.0,
                                  fontFamily: 'PoppinsSemiBold',
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar appBarCarta(String texto, IconData icono, int constante, Color color) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        Hero(
          tag: constante,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(icono, color: color),
          ),
        ),
      ],
      title: Text(
        texto,
        style: TextStyle(
            color: kLetras, fontSize: 20.0, fontFamily: 'PoppinsRegular'),
      ),
      centerTitle: true,
      iconTheme: IconThemeData(
        color: kLetras, //change your color here
      ),
    );
  }
}
