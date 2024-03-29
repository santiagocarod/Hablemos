import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/diagnostico.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:url_launcher/url_launcher.dart';

/// Clase encargada de desplegar informacion especifica de un [Diagnostico]
///
/// Muestra toda la información para un solo [Diagnostico]
class InformationDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Diagnostico trastorno = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;

    return Container(
      color: kAmarillo,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: crearAppBar('', null, 0, null, context: context),
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

///Display de los detalles del [Diagnostico]
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
        _listSecctionUrl('Fuente Información', trastorno.fuentes, size),
      ],
    ),
  );
}

///Display de los detalles de secciones de [Diagnostico]
Widget _simpleSecction(String title, String content, Size size) {
  return Container(
    padding: EdgeInsets.only(right: 10.0, left: 10.0),
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
        Text(
          content,
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 17.0,
            color: kNegro,
            fontFamily: 'PoppinsRegular',
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

///Display de listas de String de un [Diagnostico]
Widget _listSecction(String title, List<String> content, Size size) {
  return Container(
    padding: EdgeInsets.only(right: 10.0, left: 10.0),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _list(content),
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

///Agregar widget a la lista desplegada en [_listSecction()]
List<Widget> _list(List<String> content) {
  List<Widget> info = [];
  content.forEach((element) {
    Widget inf = SelectableText(
      element,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: 17.0,
        color: kNegro,
        fontFamily: 'PoppinsRegular',
      ),
    );

    info.add(inf);
    info.add(SizedBox(height: 10));
  });

  return info;
}

///Display de listas de String que puede contener url de un [Diagnostico]
Widget _listSecctionUrl(String title, List<String> content, Size size) {
  return Container(
    padding: EdgeInsets.only(right: 10.0, left: 10.0),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _listUrl(content),
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

///Agregar widget a la lista desplegada en [_listSecctionUrl()]
List<Widget> _listUrl(List<String> content) {
  List<Widget> info = [];
  content.forEach((element) {
    Widget inf;
    if (element.contains(new RegExp(r'http', caseSensitive: false))) {
      inf = GestureDetector(
        onTap: () {
          _launchInBrowser(element);
        },
        child: Text(
          element,
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.blue[900],
            fontFamily: 'PoppinsRegular',
            decoration: TextDecoration.underline,
          ),
        ),
      );
    } else {
      inf = SelectableText(
        element,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: 17.0,
          color: kNegro,
          fontFamily: 'PoppinsRegular',
        ),
      );
    }

    info.add(inf);
    info.add(SizedBox(height: 10));
  });

  return info;
}

///Metodo que abre un url especifico
///
///El valor de [url] viene definido ya en el [Diagnostico]
Future<void> _launchInBrowser(String url) async {
  url = url.replaceAll(new RegExp(r"\s+"), "");
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
