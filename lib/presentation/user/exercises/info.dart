import 'package:flutter/material.dart';
import 'package:hablemos/ux/atoms.dart';

import '../../../constants.dart';

class InfoClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBar('', null, 0, null),
      body: Stack(
        children: <Widget>[
          _superior(size),
          Align(
            child: _infoCard(size),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }

  Widget _superior(Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.65,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(30.0),
          bottomEnd: Radius.circular(30.0),
        ),
        color: kAzul1,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 2.0),
          )
        ],
      ),
    );
  }

  Widget _infoCard(Size size) {
    return Container();
  }
}
