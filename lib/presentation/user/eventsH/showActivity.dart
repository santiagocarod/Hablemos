import 'package:flutter/material.dart';
import 'package:hablemos/model/actividad.dart';
import 'package:hablemos/ux/atoms.dart';

class ShowActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Actividad actividad = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBar(actividad.titulo, null, 0, null),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 100.0,
            ),
            Center(
              child: Container(
                width: 272.0,
                height: 196.0,
                decoration: BoxDecoration(
                  image: actividad.foto,
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
          ],
        ),
      ),
    );
  }
}
