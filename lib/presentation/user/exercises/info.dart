import 'package:flutter/material.dart';
import 'package:hablemos/model/ejercicio.dart';
import 'package:hablemos/ux/atoms.dart';

import '../../../constants.dart';

class InfoClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Ejercicio ej = ModalRoute.of(context).settings.arguments;

    Size size = MediaQuery.of(context).size;
    return Container(
      color: kAzul1,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: crearAppBar('', null, 0, null, context: context),
          body: Stack(
            children: <Widget>[
              _superior(size),
              Align(
                child: _infoCard(size, ej),
                alignment: Alignment.center,
              ),
            ],
          ),
        ),
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

  Widget _infoCard(Size size, Ejercicio ej) {
    return Container(
      width: size.width * 0.7,
      height: size.height * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(30.0),
          bottomEnd: Radius.circular(30.0),
          topStart: Radius.circular(30.0),
          topEnd: Radius.circular(30.0),
        ),
        color: kVerdeMuyClaro,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 2.0),
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                ej.titulo,
                style: TextStyle(fontSize: 40.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 25.0,
              ),
              Text(
                ej.descripcion,
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
