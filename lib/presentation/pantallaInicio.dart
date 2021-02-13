import 'package:flutter/material.dart';
import 'body.dart';

class PantallaInicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: buildAppBar(),
        body: Body(
          size: size,
          username: "Diana",
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 10,
    );
  }
}
