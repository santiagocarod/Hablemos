import 'package:flutter/material.dart';
import 'package:hablemos/model/grupo.dart';
import 'package:hablemos/ux/atoms.dart';

class ShowSupportGroup extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Grupo grupoApoyo = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBar(grupoApoyo.titulo, null, 0, null),
      body: Stack(
        children: <Widget>[],
      ),
    );
  }
}
