import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';

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
