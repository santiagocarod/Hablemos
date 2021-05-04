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
                                      _buildDialog(context),
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

  // Confirm popup dialog
  Widget _buildDialog(BuildContext context) {
    String title = "";
    String content = "";
    return new AlertDialog(
      title: Text(
        'Confirmación Envío de Carta',
        style: TextStyle(
          color: kNegro,
          fontSize: 15.0,
          fontFamily: 'PoppinsRegular',
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        '¿Estás seguro que desea enviar esta carta?',
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          "Su carta fue enviada exitosamente, espere la aprobación de nuestro equipo para su publicación";
                      state = true;
                    } else {
                      title = 'Error de envío';
                      content =
                          "Hubo un error enviando la carta, inténtelo nuevamente";
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
      ],
    );
  }
}
