import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/paciente.dart';
import 'package:hablemos/ux/atoms.dart';

/// Clase encargada de Desplegar solo la información necesaria de un [Paciente] al profesional
///
/// Recibe la informacion del paciente como un parametro del constructor de la clase
class PacientDetails extends StatefulWidget {
  final Paciente paciente;
  const PacientDetails({this.paciente});
  @override
  _PacientDetails createState() => _PacientDetails();
}

class _PacientDetails extends State<PacientDetails> {
  @override
  Widget build(BuildContext context) {
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
              pacientHead(size, widget.paciente),
              Container(
                padding: EdgeInsets.only(top: size.height * 0.45),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: _body(size, widget.paciente),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Mostrar el Appbar principal de la pantalla
  Widget pacientHead(Size size, Paciente paciente) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: size.height * 0.48,
            width: double.infinity,
            color: kRosado,
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    // Draw profile picture
                    Container(
                      padding: EdgeInsets.only(top: 30),
                      alignment: Alignment.topCenter,
                      child: ClipOval(
                        child: Container(
                          color: Colors.white,
                          width: 200.0,
                          height: 200.0,
                          child: paciente.foto == null
                              ? Icon(
                                  Icons.account_circle,
                                  color: Colors.indigo[100],
                                  size: 200.0,
                                )
                              : Image.network(
                                  paciente.foto,
                                  width: 200.0,
                                  height: 200.0,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                    alignment: Alignment.topCenter,
                    child: AutoSizeText(
                      paciente.nombre + " " + paciente.apellido,
                      maxFontSize: 60.0,
                      minFontSize: 20.0,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kNegro,
                        fontFamily: 'PoppinsRegular',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Cuerpo principal, en donde se despliega cada sección importante
  Widget _body(Size size, Paciente paciente) {
    return Container(
      width: size.width,
      child: Column(
        children: <Widget>[
          _section('Correo', paciente.correo),
          _section('Ciudad', paciente.ciudad),
          _section('Fecha de Nacimiento', paciente.fechaNacimiento),
          _section('Teléfono', paciente.telefono),
          Container(
            padding: EdgeInsets.only(
                top: 10.0, bottom: 10.0, right: 15.0, left: 15.0),
            child: AutoSizeText(
              'Información Contacto de Emergencia',
              maxLines: 1,
              maxFontSize: 20.0,
              minFontSize: 10.0,
              style: TextStyle(
                fontSize: 20.0,
                color: kRojoOscuro,
                fontFamily: 'PoppinsRegular',
              ),
              textAlign: TextAlign.start,
            ),
          ),
          _section('Nombre', paciente.nombreContactoEmergencia ?? "Fal "),
          _section('Teléfono', paciente.telefonoContactoEmergencia ?? "fatl "),
          _section('Relación', paciente.relacionContactoEmergencia ?? "tal "),
        ],
      ),
    );
  }

  /// Sección general con un titulo [title] y contenido [content]
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
            content,
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
}
