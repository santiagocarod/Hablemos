import 'package:flutter/material.dart';
import 'package:hablemos/model/ejercicio.dart';
import 'package:hablemos/presentation/user/exercises/provider/ejerciciosEstaticos.dart';
import 'package:hablemos/ux/atoms.dart';

import '../../../constants.dart';

/// Clase principal que contiene las informacion detallada de algun ejercicio en especifico
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
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: generarPasos(ej.pasos, mindfulnessAcom1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> generarPasos(List<String> pasos, List<String> imagenes) {
    List<Widget> lista = [];
    int index = 0;
    for (String paso in pasos) {
      lista.add(Container(
        child: Image.asset(
          imagenes[index],
          // height: 50,
          // width: 50,
        ),
      ));
      lista.add(SizedBox(
        height: 10,
      ));

      lista.add(Container(
        child: Text(
          paso,
          style: TextStyle(fontSize: 20),
        ),
      ));
      lista.add(Divider(
        thickness: 5,
      ));
      lista.add(SizedBox(
        height: 20,
      ));
      index += 1;
    }

    return lista;
  }
}
