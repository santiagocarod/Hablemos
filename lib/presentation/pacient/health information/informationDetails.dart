import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/diagnostico.dart';
import 'package:hablemos/ux/atoms.dart';

class InformationDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Diagnostico trastorno = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;

    return Container(
      color: kAmarillo,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: crearAppBar('', null, 0, null),
          extendBodyBehindAppBar: true,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                crearForosUpper(size, 'Informémonos \ny hablemos',
                    Icons.monitor, 0.05, kAmarillo),
                Container(
                  padding: EdgeInsets.only(top: size.height * 0.102),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: _detail(context, size, trastorno),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _detail(BuildContext context, Size size, Diagnostico trastorno) {
  String name = trastorno.nombre.toUpperCase();
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          width: size.width,
          height: 51.13,
          color: kRosado.withOpacity(0.47),
          child: Center(
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: kNegro,
                fontFamily: 'PoppinsRegular',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        _simpleSecction('Definición', trastorno.definicion, size),
        _listSecction('Síntomas', trastorno.sintomas, size),
        _simpleSecction('Autoayuda y Afrontamiento', trastorno.autoayuda, size),
        _listSecction('Fuente Información', trastorno.fuentes, size),
      ],
    ),
  );
}

Widget _simpleSecction(String title, String content, Size size) {
  return Container(
    padding: EdgeInsets.only(right: 10.0, left: 10.0),
    width: size.width,
    height: size.height * 0.25,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              color: kRojoOscuro,
              fontFamily: 'PoppinsRegular',
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Text(
              content,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 17.0,
                color: kNegro,
                fontFamily: 'PoppinsRegular',
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Divider(
            color: Colors.black.withOpacity(0.40),
          ),
        ),
      ],
    ),
  );
}

Widget _listSecction(String title, List<String> content, Size size) {
  return Container(
    padding: EdgeInsets.only(right: 10.0, left: 10.0),
    width: size.width,
    height: size.height * 0.20,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              color: kRojoOscuro,
              fontFamily: 'PoppinsRegular',
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _list(content),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Divider(
            color: Colors.black.withOpacity(0.40),
          ),
        ),
      ],
    ),
  );
}

List<Widget> _list(List<String> content) {
  List<Widget> info = [];
  content.forEach((element) {
    Text inf = Text(
      element,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: 17.0,
        color: kNegro,
        fontFamily: 'PoppinsRegular',
      ),
    );
    info.add(inf);
  });

  return info;
}
