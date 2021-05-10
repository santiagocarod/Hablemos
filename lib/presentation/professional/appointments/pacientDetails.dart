import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/paciente.dart';
import 'package:hablemos/ux/atoms.dart';

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
          // Create an empty appBar, display the arrow back
          appBar: crearAppBar('', null, 0, null, context: context),
          extendBodyBehindAppBar: true,
          body: Stack(
            children: <Widget>[
              pacientHead(size, widget.paciente),
              Container(
                padding: EdgeInsets.only(top: (size.height / 2)),
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

  // Draw app bar Style
  Widget pacientHead(Size size, Paciente paciente) {
    return Stack(
      children: <Widget>[
        // Draw oval Shape
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: (size.height / 2),
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
                                  paciente.foto.toString(),
                                  width: 200.0,
                                  height: 200.0,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Display text name
                Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                    alignment: Alignment.topCenter,
                    child: Text(
                      paciente.nombre + " " + paciente.apellido,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kNegro,
                        fontSize: (size.height / 2) * 0.09,
                        fontFamily: 'PoppinsRegular',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Body of the screen
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
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(
              'Información Contacto de Emergencia',
              style: TextStyle(
                fontSize: 20.0,
                color: kRojoOscuro,
                fontFamily: 'PoppinsRegular',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          _section('Nombre', paciente.nombreContactoEmergencia ?? "Fal "),
          _section('Teléfono', paciente.telefonoContactoEmergencia ?? "fatl "),
          _section('Relación', paciente.relacionContactoEmergencia ?? "tal "),
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
