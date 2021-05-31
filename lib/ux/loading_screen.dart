import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';

/// Clase que contiene la estructura de la pantalla de carga mientras los datos son traidos desde Firebase

Widget loadingScreen() {
  return Scaffold(
    backgroundColor: Colors.transparent,
    body: Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              backgroundColor: kAmarillo,
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(kRojo),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Cargando...',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ),
  );
}
