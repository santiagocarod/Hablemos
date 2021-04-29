import 'package:flutter/material.dart';
import 'package:hablemos/ux/atoms.dart';

import '../../../constants.dart';

class AddLetter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: crearAppBarEventos(
            context, 'Crear una Carta', 'listaCartasPaciente'),
        body: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/background_cartas.png',
              alignment: Alignment.center,
              fit: BoxFit.fill,
              width: size.width,
              height: size.height,
            ),
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
                      inputTextBox("Titulo", "Titulo", Icons.title),
                      inputTextBoxMultiline("Cuerpo", "Cuerpo", Icons.subject),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return dialogoConfirmacion(
                                      context,
                                      "listaCartasPaciente",
                                      "Confirmación Envio de Carta",
                                      "¿Estás seguro que deseas enviar esta carta?");
                                });
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
    );
  }
}
