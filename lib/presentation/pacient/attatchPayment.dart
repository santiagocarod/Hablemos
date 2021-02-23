import 'package:flutter/material.dart';
import 'package:hablemos/ux/atoms.dart';

class AttatchPayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: crearAppBar("Adjuntar Pago"),
      body: Stack(children: [
        Image.asset(
          'assets/images/yellowBack.png',
          alignment: Alignment.center,
          fit: BoxFit.fill,
          width: size.width,
          height: size.height,
        ),
        Center(
          child: iconButtonBig("Subir prueba de pago", () => {},
              Icons.cloud_upload, Colors.yellow[700]),
        ),
      ]),
    );
  }
}
