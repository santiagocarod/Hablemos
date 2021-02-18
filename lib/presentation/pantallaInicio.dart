import 'package:flutter/material.dart';
import '../constants.dart';
import 'body.dart';

class PantallaInicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: buildAppBar(size),
        body: Body(
          size: size,
          username: "Diana",
        ));
  }

  AppBar buildAppBar(Size size) {
    //EncabezadoHablemos(size: size, text1: "Diana");
    return AppBar(
      backgroundColor: kAzulPrincipal,
      elevation: 0,
      toolbarHeight: size.height * 0.001,
      leading: Container(),
    );
  }
}
