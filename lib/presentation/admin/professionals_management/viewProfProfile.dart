import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants.dart';

class ViewProfProfileManagement extends StatefulWidget {
  @override
  _ViewProfProfileManagementState createState() =>
      _ViewProfProfileManagementState();
}

class _ViewProfProfileManagementState extends State<ViewProfProfileManagement> {
  File _image;
  final ImagePicker _imagePicker = new ImagePicker();

  // Set the image form camera
  _imagenDesdeCamara() async {
    PickedFile image = await _imagePicker.getImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = File(image.path);
    });
  }

  // Set the image form gallery
  _imagenDesdeGaleria() async {
    PickedFile image = await _imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(image.path);
    });
  }

  // Display options (Camera or Gallery)
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galeria de Fotos'),
                      trailing: new Icon(Icons.cloud_upload),
                      onTap: () {
                        _imagenDesdeGaleria();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Cámara'),
                    trailing: new Icon(Icons.cloud_upload),
                    onTap: () {
                      _imagenDesdeCamara();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Profesional profesional = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      // Create an empty appBar, display the arrow back
      appBar: crearAppBar('', null, 0, null),
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
                      Navigator.pushNamed(
                          context, 'editarPerfilProfesionalManage',
                          arguments: profesional);
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
                // Display text name
                Center(
                  child: Container(
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
          // _section('Correo', profesional.correo),
          _section('Ciudad', 'Bogota D.C'),
          _sectionList('Convenio', profesional.convenios, size),
          _section('Especialidad', profesional.especialidades),
          _sectionList('Proyectos', profesional.proyectos, size),
          _section('Experiencia', profesional.experiencia),
          _section('Descripcion', profesional.descripcion),
          // _sectionList('Redes Sociales', profesional.redes, size),
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
}
