import 'package:flutter/material.dart';
import 'package:hablemos/ux/atoms.dart';

class AddLetter extends StatelessWidget {
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
            appBar: crearAppBar("Crea una Carta", null, 0, null),
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
                          inputTextBox("Titulo", "Titulo", Icons.title),
                          inputTextBoxMultiline(
                              "Cuerpo", "Cuerpo", Icons.subject),
                          SizedBox(
                            height: 20,
                          ),
                          iconButtonBig("Guardar", () => {}, Icons.save,
                              Colors.yellow[700])
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
}
