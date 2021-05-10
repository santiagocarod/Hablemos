import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/ux/atoms.dart';

class ProfessionalDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Profesional profesional = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    return Container(
      color: kRosado,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: crearAppBar('', null, 0, null, context: context),
          extendBodyBehindAppBar: true,
          body: Stack(
            children: <Widget>[
              cabeceraPerfilProfesional(size, profesional),
              Container(
                padding: EdgeInsets.only(top: size.height * 0.49),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: cuerpoPerfilProfesional(size, profesional),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget cabeceraPerfilProfesional(Size size, Profesional profesional) {
    return Stack(
      children: <Widget>[
        // Draw oval Shape
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: size.height * 0.50,
            width: double.infinity,
            color: kRosado,
          ),
        ),
        // Draw profile picture
        Container(
          padding: EdgeInsets.only(top: size.height * 0.05),
          alignment: Alignment.topCenter,
          child: ClipOval(
            child: Container(
              color: Colors.white,
              width: 200,
              height: 200,
              child: profesional.foto == null
                  ? Icon(
                      Icons.account_circle,
                      color: Colors.indigo[100],
                      size: 200,
                    )
                  : Image.network(
                      profesional.foto.toString(),
                      width: 200,
                      height: 200,
                    ),
            ),
          ),
        ),
        // Display text name
        Center(
          child: Container(
            padding: EdgeInsets.only(top: size.height * 0.30),
            alignment: Alignment.topCenter,
            child: Text(
              profesional.nombre + " " + profesional.apellido,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kNegro,
                fontSize: (size.height / 2) * 0.08,
                fontFamily: 'PoppinsRegular',
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            padding: EdgeInsets.only(top: size.height * 0.35),
            alignment: Alignment.topCenter,
            child: Text(
              'Profesional',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kRojo,
                fontSize: (size.height / 2) * 0.07,
                fontFamily: 'PoppinsRegular',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget cuerpoPerfilProfesional(Size size, Profesional profesional) {
    return Container(
      width: size.width,
      child: Column(
        children: <Widget>[
          _section('Correo', profesional.correo),
          _section('Ciudad', profesional.ciudad ?? ''),
          _sectionList('Convenio', profesional.convenios, size ?? ['']),
          _section('Especialidad', profesional.especialidad ?? ''),
          _sectionList('Proyectos', profesional.proyectos, size ?? ['']),
          _section('Experiencia', profesional.experiencia ?? ''),
          _section('Descripcion', profesional.descripcion ?? ''),
        ],
      ),
    );
  }

  // Section, title, content and divider
  Widget _section(String title, String content) {
    return Container(
      padding: EdgeInsets.only(right: 15.0, left: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              color: kRojoOscuro,
              fontFamily: 'PoppinsRegular',
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            content == null ? " " : content,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 15.0,
              color: kNegro,
              fontFamily: 'PoppinsRegular',
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5.0),
            child: Divider(
              color: Colors.black.withOpacity(0.40),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionList(String title, List<String> content, Size size) {
    return Container(
      padding: EdgeInsets.only(right: 15.0, left: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 0, bottom: 0),
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
            children: content != null ? _list(content) : [Text(" ")],
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
        '- $element',
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: 15.0,
          color: kNegro,
          fontFamily: 'PoppinsRegular',
        ),
      );
      info.add(inf);
    });

    return info;
  }
}
