import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hablemos/business/admin/negocioProfesionales.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/presentation/admin/professionals_management/editProfProfileAdmin.dart';
import 'package:hablemos/ux/atoms.dart';

import '../../../constants.dart';

class ViewProfProfileManagement extends StatefulWidget {
  @override
  _ViewProfProfileManagementState createState() =>
      _ViewProfProfileManagementState();
}

class _ViewProfProfileManagementState extends State<ViewProfProfileManagement> {
  File _image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Profesional profesional = ModalRoute.of(context).settings.arguments;

    print(profesional.uid);
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
              cabeceraPerfilProfesional(size, profesional),
              Container(
                padding: EdgeInsets.only(top: size.height * 0.53),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: cuerpoPerfilProfesional(size, profesional),
                ),
              ),
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
            height: size.height * 0.58,
            width: double.infinity,
            color: kRosado,
            child: Column(
              children: <Widget>[
                // Draw profile picture
                Container(
                  padding: EdgeInsets.only(top: size.height * 0.05),
                  alignment: Alignment.topCenter,
                  child: ClipOval(
                    child: Container(
                      color: Colors.white,
                      width: 200,
                      height: 200,
                      child: _image == null
                          ? Icon(
                              Icons.account_circle,
                              color: Colors.indigo[100],
                              size: 200,
                            )
                          : Image.file(
                              _image,
                              width: 200,
                              height: 200,
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                // Plus icon and edit text
                Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditProfileProfessionalAdmin(
                              profesional: profesional)));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.add_circle_outline,
                          size: 20.0,
                          color: kNegro,
                        ),
                        Text(
                          ' Modificar',
                          style: TextStyle(
                            color: kNegro,
                            fontSize: 15.0,
                            fontFamily: 'PoppinsRegular',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                // Display text name
                Center(
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Text(
                      profesional.nombre + " " + profesional.apellido,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kNegro,
                        fontSize: (size.height / 2) * 0.06,
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
                        fontSize: (size.height / 2) * 0.06,
                        fontFamily: 'PoppinsRegular',
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildDialog(context, profesional),
                    );
                  },
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.only(top: 15.0),
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Eliminar Cuenta',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kNegro,
                          fontSize: 15.0,
                          fontFamily: 'PoppinsRegular',
                          fontWeight: FontWeight.w500,
                        ),
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

  Widget cuerpoPerfilProfesional(Size size, Profesional profesional) {
    return Container(
      width: size.width,
      child: Column(
        children: <Widget>[
          _section('Correo', profesional.correo),
          _section('Ciudad', profesional.ciudad ?? " "),
          _section('Telefono', profesional.celular ?? " "),
          _sectionList('Convenio', profesional.convenios ?? [" "], size),
          _section('Especialidad', profesional.especialidad ?? " "),
          _sectionList('Proyectos', profesional.proyectos ?? [" "], size),
          _section('Experiencia', profesional.experiencia ?? " "),
          _section('Descripcion', profesional.descripcion ?? " "),
          Container(
            padding: EdgeInsets.only(right: 15.0, left: 15.0),
            alignment: Alignment.topLeft,
            child: Text(
              "Información Bancaria",
              style: TextStyle(
                fontSize: 24.0,
                color: kRojoOscuro,
                fontFamily: 'PoppinsRegular',
              ),
              textAlign: TextAlign.left,
            ),
          ),
          _section('Banco', profesional.banco.banco ?? " "),
          _section('Número de Cuenta', profesional.banco.numCuenta ?? " "),
          _section('Tipo de Cuenta', profesional.banco.tipoCuenta ?? " "),

          //_sectionList('Redes Sociales', profesional.redes, size),
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

  //Confirm PopUp Dialog
  Widget _buildDialog(BuildContext context, Profesional profesional) {
    return new AlertDialog(
      title: Text(
        'Confirmación de Eliminación',
        style: TextStyle(
          color: kNegro,
          fontSize: 15.0,
          fontFamily: 'PoppinsRegular',
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        '¿Está seguro que desea eliminar \npermanentemente \neste perfil?',
        style: TextStyle(
          color: kNegro,
          fontSize: 14.0,
          fontFamily: 'PoppinsRegular',
        ),
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(37.0),
        side: BorderSide(color: kNegro, width: 2.0),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                eliminarUsuario(profesional);
                eliminarProfesional(profesional).then((value) {
                  if (value) {
                    Navigator.pushNamed(context, 'adminManageProffessional');
                  } else if (!value) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                minimumSize: Size(99.0, 30.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0),
                  side: BorderSide(color: kNegro),
                ),
                shadowColor: Colors.black,
              ),
              child: const Text(
                'Si',
                style: TextStyle(
                  color: kNegro,
                  fontSize: 14.0,
                  fontFamily: 'PoppinsRegular',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                minimumSize: Size(99.0, 30.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0),
                  side: BorderSide(color: kNegro),
                ),
                shadowColor: Colors.black,
              ),
              child: const Text(
                'No',
                style: TextStyle(
                  color: kNegro,
                  fontSize: 14.0,
                  fontFamily: 'PoppinsRegular',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
