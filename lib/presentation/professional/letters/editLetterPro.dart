import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/business/professional/negocioCartasPro.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/carta.dart';
import 'package:hablemos/ux/atoms.dart';

class EditLetterPro extends StatefulWidget {
  @override
  _EditLetterPro createState() => _EditLetterPro();
}

class _EditLetterPro extends State<EditLetterPro> {
  TextEditingController tituloCarta = TextEditingController();
  TextEditingController contenidoCarta = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Carta carta = ModalRoute.of(context).settings.arguments;

    tituloCarta = TextEditingController()..text = carta.titulo;
    tituloCarta.selection = TextSelection.fromPosition(
        TextPosition(offset: tituloCarta.text.length));
    contenidoCarta = TextEditingController()..text = carta.cuerpo;
    contenidoCarta.selection = TextSelection.fromPosition(
        TextPosition(offset: contenidoCarta.text.length));
    return Stack(
      children: [
        Container(
          child: Image.asset(
            'assets/images/lettersBackground.png',
            alignment: Alignment.center,
            fit: BoxFit.fill,
            width: size.width,
            height: size.height,
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: crearAppBar("Editar Carta", null, 0, null),
            body: Stack(
              children: <Widget>[
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
                                onChanged: (text2) {
                                  if (text2.isNotEmpty) {
                                    carta.titulo = text2;
                                  }
                                },
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.name,
                                controller: tituloCarta,
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
                                  onChanged: (text) {
                                    if (text.isNotEmpty) {
                                      carta.cuerpo = text;
                                    }
                                  },
                                  keyboardType: TextInputType.multiline,
                                  minLines: 20,
                                  maxLines: 50,
                                  controller: contenidoCarta,
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
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      carta.aprobado = false;
                                      return dialogoConfirmacion(
                                          context,
                                          'valorarCartaPro',
                                          "Confirmación Edición de Carta",
                                          "¿Estás seguro que deseas guardar tus modificaciones de esta carta?",
                                          carta);
                                    });
                              },
                              child: Container(
                                width: 239.0,
                                height: 43.0,
                                margin:
                                    EdgeInsets.only(bottom: size.height * 0.04),
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
        ),
      ],
    );
  }

  AppBar appBarCarta(String texto, IconData icono, int constante, Color color) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Icon(icono, color: color),
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

  @override
  void dispose() {
    tituloCarta.dispose();
    contenidoCarta.dispose();
    super.dispose();
  }
}

AlertDialog dialogoConfirmacion(BuildContext context, String rutaSi,
    String titulo, String mensaje, Carta carta) {
  String title2 = "";
  String content2 = "";
  return AlertDialog(
    shape: RoundedRectangleBorder(
        side: BorderSide(color: kNegro, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(37.0))),
    backgroundColor: kBlanco,
    content: Container(
      height: 170.0,
      width: 302.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "$titulo",
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold, fontSize: 16, color: kNegro),
          ),
          SizedBox(
            height: 25.0,
          ),
          Container(
            width: 259.0,
            height: 55.0,
            child: Text(
              "$mensaje",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  color: kNegro, fontSize: 15, fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    editarCarta(carta).then((value) {
                      bool state;
                      if (value) {
                        title2 = 'Carta modificada';
                        content2 = "La carta fue modificada exitosamente";
                        state = true;
                      } else {
                        title2 = 'Error de edición';
                        content2 =
                            "Hubo un error guardando los cambios de la carta, inténtelo nuevamente";
                        state = false;
                      }
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => adviceDialogLetter(
                                context,
                                title2,
                                content2,
                                state,
                              ));
                    });
                  },
                  child: Container(
                    height: 30,
                    width: 99,
                    decoration: BoxDecoration(
                      border: Border.all(color: kNegro),
                      borderRadius: BorderRadius.all(
                        Radius.circular(22.0),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Si",
                          style: GoogleFonts.montserrat(
                              color: kNegro,
                              fontSize: 14,
                              fontWeight: FontWeight.w300)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 30,
                    width: 99,
                    decoration: BoxDecoration(
                      border: Border.all(color: kNegro),
                      borderRadius: BorderRadius.all(
                        Radius.circular(22.0),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("No",
                          style: GoogleFonts.montserrat(
                              color: kNegro,
                              fontSize: 14,
                              fontWeight: FontWeight.w300)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
