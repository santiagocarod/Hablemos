import 'package:flutter/material.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/ux/shape_appbar_border.dart';

class ForumProfesianalHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: crearAppBar('', null, 0, null),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          crearForosUpper(size),
          Container(
            height: size.height,
            width: size.width,
            child: Center(
              child: Text('Cuerpo foros'),
            ),
          ),
        ],
      ),
    );
  }
}
