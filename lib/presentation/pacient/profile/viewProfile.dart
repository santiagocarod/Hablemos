import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/paciente.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/services/providers/pacientes_provider.dart';
import 'package:image_picker/image_picker.dart';

class ViewProfile extends StatefulWidget {
  @override
  _ViewProfile createState() => _ViewProfile();
}

class _ViewProfile extends State<ViewProfile> {
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
    final Paciente paciente = PacientesProvider.getPaciente();
    return Scaffold(
      // Create an empty appBar, display the arrow back
      appBar: crearAppBar('', null, 0, null),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          pacientHead(size, paciente),
          Container(
            padding: EdgeInsets.only(top: (size.height / 2) + 120.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: _body(size, paciente),
            ),
          ),
        ],
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
            height: (size.height / 2) + 120.0,
            width: double.infinity,
            color: kRosado,
          ),
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
        // Draw camera icon
        Container(
          padding: EdgeInsets.only(
              top: (size.height / 2) * 0.45, left: (size.width / 2) * 0.55),
          alignment: Alignment.topCenter,
          child: GestureDetector(
            onTap: () {
              _showPicker(context);
            },
            child: ClipOval(
              child: Container(
                color: Colors.white,
                width: 43.0,
                height: 43.0,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                  size: 30.0,
                ),
              ),
            ),
          ),
        ),
        // Plus icon and edit text
        Container(
          padding: EdgeInsets.only(top: 253),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'editarPerfil', arguments: paciente);
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
            padding: EdgeInsets.only(top: 283),
            alignment: Alignment.topCenter,
            child: Text(
              paciente.nombre + " " + paciente.apellido,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kNegro,
                fontSize: (size.height / 2) * 0.1,
                fontFamily: 'PoppinsRegular',
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Body of the screen
  Widget _body(Size size, Paciente paciente) {
    String fecha =
        '${paciente.fechaNacimiento.day}/${paciente.fechaNacimiento.month}/${paciente.fechaNacimiento.year}';
    return Container(
      width: size.width,
      child: Column(
        children: <Widget>[
          _section('Correo', paciente.correo),
          _sectionButton(),
          _section('Ciudad', paciente.ciudad),
          _section('Fecha de Nacimiento', fecha),
          _section('Teléfono', paciente.telefono.toString()),
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
          _section('Nombre', paciente.nombreContactoEmergencia),
          _section('Teléfono', paciente.telefonoContactoEmergencia.toString()),
          _section('Relación', paciente.relacionContactoEmergencia),
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

  // Password section and button
  Widget _sectionButton() {
    return Container(
      padding: EdgeInsets.only(right: 15.0, left: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Contraseña',
            style: TextStyle(
              fontSize: 20.0,
              color: kRojoOscuro,
              fontFamily: 'PoppinsRegular',
            ),
            textAlign: TextAlign.left,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '*******',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15.0,
                  color: kNegro,
                  fontFamily: 'PoppinsRegular',
                ),
              ),
              Container(
                width: 109.0,
                height: 29.0,
                child: ElevatedButton(
                  child: Text(
                    'Cambiar',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontFamily: 'PoppinsRegular',
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: kRojoOscuro,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(378.0),
                    ),
                    shadowColor: Colors.black,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialog(context),
                    );
                  },
                ),
              ),
            ],
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

  // Change password popup Dialog
  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: Text('Cambio de Contraseña'),
      content: Text(
        'Hemos enviado las instrucciones de restablecimiento de contraseña a tu correo electrónico.',
        textAlign: TextAlign.justify,
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            primary: kRojoOscuro,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(378.0),
            ),
            shadowColor: Colors.black,
          ),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}
