import 'package:flutter/material.dart';
import 'package:hablemos/business/pacient/negocioCartas.dart';
import 'package:hablemos/model/carta.dart';
import 'package:hablemos/ux/atoms.dart';

import '../../../constants.dart';

class AddLetter extends StatefulWidget {
  @override
  _AddLetter createState() => _AddLetter();
}

class _AddLetter extends State<AddLetter> {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _bodyController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          child: Image.asset(
            'assets/images/background_cartas.png',
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
            appBar: crearAppBarEventos(
                context, 'Crear una Carta', 'listaCartasPaciente'),
            body: Stack(
              children: <Widget>[
                Material(
                  type: MaterialType.transparency,
                  child: Padding(
                    padding: EdgeInsets.only(top: 80.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          inputTextBox("Titulo", "Titulo", Icons.title,
                              _titleController),
                          inputTextBoxMultiline("Cuerpo", "Cuerpo",
                              Icons.subject, _bodyController),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      _buildDialog(context, size),
                                );
                              },
                              child: Container(
                                width: 230.0,
                                height: 55.0,
                                margin: EdgeInsets.only(
                                    bottom: size.height * 0.04,
                                    top: size.height * 0.04),
                                decoration: BoxDecoration(
                                  color: Colors.yellow[700],
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
                                    "ENVIAR CARTA",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: kBlanco,
                                      fontSize: 18.0,
                                      fontFamily: 'PoppinsSemiBold',
                                      letterSpacing: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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

  // Dialogo Confirmación de Envío de Carta
  Widget _buildDialog(BuildContext context, Size size) {
    String title = "";
    String content = "";
    return new AlertDialog(
      title: Text(
        'Confirmación Envío de Carta',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kNegro,
          fontSize: 15.0,
          fontFamily: 'PoppinsRegular',
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        '¿Estás seguro que desea enviar esta carta?',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kNegro,
          fontSize: 14.0,
          fontFamily: 'PoppinsRegular',
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(37.0),
        side: BorderSide(color: kNegro, width: 2.0),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_titleController.text.isNotEmpty &&
                      _bodyController.text.isNotEmpty) {
                    Carta carta = new Carta(
                      titulo: _titleController.text,
                      cuerpo: _bodyController.text,
                      aprobado: false,
                    );

                    agregarCarta(carta).then((value) {
                      bool state;
                      if (value) {
                        title = 'Carta enviada';
                        content =
                            "Tu carta fue enviada exitosamente, si esta es aprobación sera publicación.";
                        state = true;
                      } else {
                        title = 'Error de envío';
                        content =
                            "Hubo un error enviando la carta, inténtalo nuevamente.";
                        state = false;
                      }
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => adviceDialogLetter(
                                context,
                                title,
                                content,
                                state,
                              ));
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(99.0, 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0),
                    side: BorderSide(color: kNegro),
                  ),
                  shadowColor: Colors.black,
                ),
                child: const Text(
                  'Si',
                  style: TextStyle(
                    color: kNegro,
                    fontSize: 14.0,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.065,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(99.0, 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0),
                    side: BorderSide(color: kNegro),
                  ),
                  shadowColor: Colors.black,
                ),
                child: const Text(
                  'No',
                  style: TextStyle(
                    color: kNegro,
                    fontSize: 14.0,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
