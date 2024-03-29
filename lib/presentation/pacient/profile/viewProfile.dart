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

import '../../../inh_widget.dart';
import 'editProfile.dart';

///Clase encargada de hacer la petición del perfil [Paciente] a firebase
///
///Solo va a desplegar la información del usuario que esta con la sesión iniciada [auth.currentUser.uid] == [Paciente.uid]
///En esta pantalla inicial no se puede editar nada sobre el perfil
///Hay un boton de editar perfil que redirige a [EditProfile()]
///Despliga la pantalla de editar perfil
class ViewProfile extends StatefulWidget {
  @override
  _ViewProfile createState() => _ViewProfile();
}

class _ViewProfile extends State<ViewProfile> {
  String _image;
  final ImagePicker _imagePicker = new ImagePicker();
  String username;

  /// Pone la imagen que viene desde camara
  _imagenDesdeCamara(Paciente paciente) async {
    PickedFile image = await _imagePicker.getImage(
        source: ImageSource.camera, imageQuality: 50);

    uploadImage(image.path, PROFILE_FOLDER).then((value) {
      if (value != null) {
        actualizarPerfil(paciente, value).then((val) {
          if (paciente.foto != "falta foto") {
            deleteImage(paciente.foto);
          }
          if (val) {
            _image = value;
            Navigator.pop(context);
            setState(() {});
          } else {
            showAlertDialog(context,
                "Hubo un error subiendo la foto, inténtalo nuevamente.");
          }
        });
      }
    });
  }

  /// Pone la imagen que viene de la galeria
  _imagenDesdeGaleria(Paciente paciente) async {
    PickedFile image = await _imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);

    uploadImage(image.path, PROFILE_FOLDER).then((value) {
      if (value != null) {
        actualizarPerfil(paciente, value).then((val) {
          if (paciente.foto != "falta foto") {
            deleteImage(paciente.foto);
          }
          if (val) {
            _image = value;
            Navigator.pop(context);
            setState(() {
              build(context);
            });
          } else {
            showAlertDialog(context,
                "Hubo un error subiendo la foto, inténtalo nuevamente.");
          }
        });
      }
    });
  }

  /// Display las opciones para subir foto (Galeria o Camara)
  void _showPicker(context, paciente) {
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
    final FirebaseAuth auth = FirebaseAuth.instance;
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
                appBar: crearAppBar('', null, 0, null, context: context),
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

  /// Display la barra superior de la pantalla
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
                          child: _image == "falta foto"
                              ? Icon(
                                  Icons.account_circle,
                                  color: Colors.indigo[100],
                                  size: 200.0,
                                )
                              : Image.network(
                                  _image,
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
                          _buildDialog(context, paciente, size),
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

  /// Display de toda la pantalla donde esta la informacion del usuario
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
            padding: EdgeInsets.only(
                top: 10.0, bottom: 10.0, right: 15.0, left: 15.0),
            child: Text(
              'Información Contacto de Emergencia',
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
          SizedBox(height: 20),
          Center(
              child: iconButtonSmall(
                  color: kRojoOscuro,
                  function: () {
                    final bloc = InhWidget.of(context);
                    bloc.changeEmail("");
                    bloc.changePassword("");

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

  /// Display la seccion que tiene un titulo y un texto
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

  /// Display la sección que tiene un password
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
                      builder: (BuildContext context) {
                        FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                        firebaseAuth.sendPasswordResetEmail(
                            email: firebaseAuth.currentUser.email);
                        return _buildPopupDialog(context);
                      },
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

  /// Display dialogo de cambiar password
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

  /// Dialogo Confirmación de Eliminación de Cuenta de Paciente.
  Widget _buildDialog(BuildContext context, Paciente paciente, Size size) {
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
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  AuthService authService = AuthService();

                  Navigator.pushNamedAndRemoveUntil(
                      context, "start", (_) => false);
                  eliminarPaciente(paciente).then((value) {
                    eliminarUsuario(paciente);
                    FirebaseAuth.instance.currentUser.delete();
                    authService.logOut();
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
              SizedBox(
                width: size.width * 0.065,
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
        ),
      ],
    );
  }
}
