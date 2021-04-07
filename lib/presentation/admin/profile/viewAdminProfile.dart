import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hablemos/model/administrador.dart';
import 'package:hablemos/services/providers/administrador_provider.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants.dart';

class ViewAdminProfile extends StatefulWidget {
  @override
  _ViewAdminProfileState createState() => _ViewAdminProfileState();
}

class _ViewAdminProfileState extends State<ViewAdminProfile> {
  File _image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Administrador admin = AdministradorProvider.getAdministrador();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: crearAppBar('', null, 0, null),
      body: Stack(
        children: <Widget>[
          adminHead(size, admin),
          Container(
            padding: EdgeInsets.only(top: size.height * 0.66),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: _body(size, admin),
            ),
          ),
        ],
      ),
    );
  }

  Widget adminHead(Size size, Administrador admin) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: (size.height / 2) + 120.0,
        width: double.infinity,
        color: kRosado,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height * 0.02,
            ),
            // Draw profile picture
            Container(
              padding: EdgeInsets.only(top: 32),
              alignment: Alignment.topCenter,
              child: ClipOval(
                child: Container(
                  color: Colors.white,
                  width: 200.0,
                  height: 200.0,
                  child: _image == null
                      ? Icon(
                          Icons.account_circle,
                          color: Colors.indigo[100],
                          size: 200.0,
                        )
                      : Image.file(
                          _image,
                          width: 200.0,
                          height: 200.0,
                        ),
                ),
              ),
            ),
            // Plus icon and edit text
            SizedBox(
              height: size.height * 0.01,
            ),
            Center(
              child: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  admin.nombre + " " + admin.apellido,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kNegro,
                    fontSize: (size.height / 2) * 0.1,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Center(
              child: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  'Administrador',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kRojo,
                    fontSize: (size.height / 2) * 0.06,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(Size size, Administrador admin) {
    return Container(
      width: size.width,
      child: Column(
        children: <Widget>[
          _section('Correo', admin.correo),
          _section('Ciudad', admin.ciudad),
          _section('Permisos', admin.permisos),
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
