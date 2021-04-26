import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/foro.dart';
import 'package:hablemos/model/respuesta.dart';
import 'package:hablemos/model/tema.dart';
import 'package:hablemos/services/providers/foros_provider.dart';
import 'package:hablemos/ux/atoms.dart';

class ViewResponse extends StatelessWidget {
  final Foro foro = ForoProvider.getForo()[0];
  final Tema tema = ForoProvider.getForo()[0].temas[0];
  final Respuesta respuesta = ForoProvider.getForo()[0].temas[0].respuestas[0];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //final Tema tema = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: crearAppBar('', null, 0, null),
        body: Stack(
          children: [
            _background(size),
            _appBar(size),
            Container(
              padding: EdgeInsets.only(top: size.height * 0.1),
              child: SingleChildScrollView(
                child: Container(
                  height: size.height,
                  width: double.infinity,
                  child: _bodyInfoForum(context, size),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _background(Size size) {
    return Image.asset(
      'assets/images/purpleBackground.png',
      alignment: Alignment.center,
      fit: BoxFit.fill,
      width: size.width,
      height: size.height,
    );
  }

  Widget _appBar(Size size) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: size.height * 0.05, bottom: 10.0),
        child: Column(
          children: <Widget>[
            Text(
              'Foros',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'PoppinsRegular',
                fontSize: 21.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bodyInfoForum(BuildContext context, Size size) {
    return Column(
      children: <Widget>[
        SizedBox(height: size.height * 0.10),
        _widgetInfoForo(context, size),
        SizedBox(height: 30.0),
        Container(
          height: 41.0,
          color: kPurpura,
          child: Center(
            child: Text(
              'TU RESPUESTA',
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'PoppinsRegular',
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
          ),
        ),
        _widgetRespuestaTema(context, size),
      ],
    );
  }

  Widget _widgetInfoForo(BuildContext context, Size size) {
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Container(
        width: size.width * 0.7,
        height: size.width * 0.4,
        padding: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
        child: Column(
          children: <Widget>[
            Text(
              foro.titulo,
              style: TextStyle(
                fontSize: 25.0,
                fontFamily: 'PoppinsRegular',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              foro.descripcion,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'PoppinsRegular',
                fontSize: 20.0,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(41.0),
          color: kMoradoClarito,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
              spreadRadius: 0.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _widgetRespuestaTema(BuildContext context, Size size) {
    return Container(
      width: size.width,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                width: 101.0,
                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                child: Text(
                  'Título:',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'PoppinsRegular',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: size.width - 102.0,
                padding: EdgeInsets.only(right: 10.0, top: 10.0),
                child: Text(
                  respuesta.cuerpoRespuesta,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'PoppinsRegular',
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Divider(
              color: Colors.black.withOpacity(0.40),
            ),
          ),
          Container(
            width: size.width,
            padding: EdgeInsets.only(right: 10.0, left: 10.0),
            child: Text(
              'Holaaaaaaaaaaaaaaaaaaaaaaaaaa',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'PoppinsRegular',
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
