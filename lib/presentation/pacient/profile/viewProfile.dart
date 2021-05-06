import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/business/cloudinary.dart';
import 'package:hablemos/business/pacient/negocioPaciente.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/paciente.dart';
import 'package:hablemos/services/auth.dart';
import 'package:hablemos/util/snapshotConvertes.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/ux/loading_screen.dart';
import 'package:image_picker/image_picker.dart';

import 'editProfile.dart';

class ViewProfile extends StatefulWidget {
  @override
  _ViewProfile createState() => _ViewProfile();
}

class _ViewProfile extends State<ViewProfile> {
  String _image;
  final ImagePicker _imagePicker = new ImagePicker();
  String username;

  // Set the image form camera
  _imagenDesdeCamara(Paciente paciente) async {
    PickedFile image = await _imagePicker.getImage(
        source: ImageSource.camera, imageQuality: 50);

    uploadImage(image.path, PROFILE_FOLDER).then((value) {
      if (value != null) {
        actualizarPerfil(paciente, value).then((val) {
          if (val) {
            _image = value;
            Navigator.pop(context);
            setState(() {});
          } else {
            showAlertDialog(context,
                "Hubo un error subiendo la foto, inténtelo nuevamente");
          }
        });
      }
    });
  }

  // Set the image form gallery
  _imagenDesdeGaleria(Paciente paciente) async {
    PickedFile image = await _imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);

    uploadImage(image.path, PROFILE_FOLDER).then((value) {
      if (value != null) {
        actualizarPerfil(paciente, value).then((val) {
          if (val) {
            _image = value;
            Navigator.pop(context);
            setState(() {
              build(context);
            });
          } else {
            showAlertDialog(context,
                "Hubo un error subiendo la foto, inténtelo nuevamente");
          }
        });
      }
    });
  }

  // Display options (Camera or Gallery)
  void _showPicker(context, paciente) {
    deleteImage(paciente.foto);
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
                        _imagenDesdeGaleria(paciente);
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Cámara'),
                    trailing: new Icon(Icons.cloud_upload),
                    onTap: () {
                      _imagenDesdeCamara(paciente);
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
    final FirebaseAuth auth = FirebaseAuth.instance; //OBTENER EL USUARIO ACTUAL
    final User user = auth.currentUser;

    Query pacientsCollection = FirebaseFirestore.instance
        .collection("pacients")
        .where("uid", isEqualTo: user.uid);
    return StreamBuilder<QuerySnapshot>(
        stream: pacientsCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('ALGO SALIO MAL');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingScreen();
          }

          Paciente paciente = pacienteMapToList(snapshot)[0];
          _image = paciente.foto;
          return Container(
            color: kRosado,
            child: SafeArea(
              bottom: false,
              child: Scaffold(
                // Create an empty appBar, display the arrow back
                appBar: crearAppBar('', null, 0, null),
                extendBodyBehindAppBar: true,
                body: Stack(
                  children: <Widget>[
                    pacientHead(size, paciente, user),
                    Container(
                      padding: EdgeInsets.only(top: (size.height / 2) + 70.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: _body(size, paciente),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  // Draw app bar Style
  Widget pacientHead(Size size, Paciente paciente, User user) {
    return Stack(
      children: <Widget>[
        // Draw oval Shape
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: (size.height / 2) + 80.0,
            width: double.infinity,
            color: kRosado,
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
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
                              : Image.network(
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
                          top: (size.height / 2) * 0.45,
                          left: (size.width / 2) * 0.55),
                      alignment: Alignment.topCenter,
                      child: GestureDetector(
                        onTap: () {
                          _showPicker(context, paciente);
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
                  ],
                ),
                // Plus icon and edit text
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              EditProfile(paciente: paciente)));
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
                    padding: EdgeInsets.only(top: 0),
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
                SizedBox(
                  height: 5.0,
                ),
                //Button Delete Profile
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildDialog(context, paciente),
                    );
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 40.0,
                      //width: 87.0,
                      margin: EdgeInsets.only(top: 10.0, right: 5.0),
                      //alignment: Alignment.topRight,
                      child: Text(
                        "Eliminar Cuenta",
                        style: TextStyle(
                            fontFamily: 'PoppinSemiBold', fontSize: 14.0),
                        textAlign: TextAlign.center,
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

  // Body of the screen
  Widget _body(Size size, Paciente paciente) {
    return Container(
      width: size.width,
      child: Column(
        children: <Widget>[
          _section('Correo', paciente.correo),
          _sectionButton(),
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
          SizedBox(height: 20),
          Center(
              child: iconButtonSmall(
                  color: kRojoOscuro,
                  function: () {
                    AuthService authService = AuthService();
                    authService.logOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/", (_) => false);
                  },
                  iconData: Icons.logout,
                  text: "Cerrar Sesion")),
          SizedBox(height: 20)
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

  //Confirm PopUp Dialog
  Widget _buildDialog(BuildContext context, Paciente paciente) {
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
                AuthService authService = AuthService();
                authService.logOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, "start", (_) => false);
                eliminarPaciente(paciente).then((value) {
                  eliminarUsuario(paciente);
                  if (value) {
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
