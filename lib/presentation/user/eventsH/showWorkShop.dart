import 'package:flutter/material.dart';
import 'package:hablemos/model/taller.dart';
import 'package:hablemos/ux/atoms.dart';

class ShowWorkShop extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Taller taller = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBar(taller.titulo, null, 0, null),
      body: Stack(
        children: <Widget>[],
      ),
    );
  }
}
