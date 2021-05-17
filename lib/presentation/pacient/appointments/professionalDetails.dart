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
            height: size.height * 0.55,
            width: double.infinity,
            color: kRosado,
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: size.height * 0.05),
              alignment: Alignment.topCenter,
              child: ClipOval(
                child: Container(
                  color: Colors.white,
                  child: profesional.foto == null
                      ? Icon(
                          Icons.account_circle,
                          color: Colors.indigo[100],
                          size: 200,
                        )
                      : Image.network(
                          profesional.foto,
                          width: 200,
                          height: 200,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes
                                    : null,
                              ),
                            );
                          },
                        ),
                ),
              ),
            ),
            // Display text name
            Center(
              child: Container(
                padding: EdgeInsets.only(
                    top: 15.0,
                    bottom: 5.0,
                    right: size.width * 0.05,
                    left: size.width * 0.05),
                alignment: Alignment.topCenter,
                child: Text(
                  profesional.nombre + " " + profesional.apellido,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: kNegro,
                    fontSize: (size.height / 2) * 0.05,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  'Profesional',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kRojo,
                    fontSize: 17,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
              ),
            ),
          ],
        ),
        // Draw profile picture
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
          _section('Especialidad', profesional.especialidad ?? ''),
          _section('Descripcion', profesional.descripcion ?? ''),
          _section('Experiencia', profesional.experiencia ?? ''),
          _sectionList('Convenio', profesional.convenios, size ?? ['']),
          _sectionList('Proyectos', profesional.proyectos, size ?? ['']),
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
