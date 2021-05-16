import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/business/cloudinary.dart';
import 'package:hablemos/business/professional/negocioProfesional.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/presentation/professional/profile/profile_pro_edit.dart';
import 'package:hablemos/services/auth.dart';
import 'package:hablemos/util/snapshotConvertes.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/ux/loading_screen.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProView extends StatefulWidget {
  @override
  _ProfileProViewState createState() => _ProfileProViewState();
}

class _ProfileProViewState extends State<ProfileProView> {
  String _image;
  final ImagePicker _imagePicker = new ImagePicker();
  final String id = FirebaseAuth.instance.currentUser.uid;

  // Set the image form camera
  _imagenDesdeCamara(Profesional profesional) async {
    PickedFile image = await _imagePicker.getImage(
        source: ImageSource.camera, imageQuality: 50);

    uploadImage(image.path, PROFILE_FOLDER).then((value) {
      if (value != null) {
        actualizarPerfilPro(profesional, value).then((val) {
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
  _imagenDesdeGaleria(Profesional profesional) async {
    PickedFile image = await _imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);

    uploadImage(image.path, PROFILE_FOLDER).then((value) {
      if (value != null) {
        actualizarPerfilPro(profesional, value).then((val) {
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
  void _showPicker(context, profesional) {
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
                        _imagenDesdeGaleria(profesional);
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Cámara'),
                    trailing: new Icon(Icons.cloud_upload),
                    onTap: () {
                      _imagenDesdeCamara(profesional);
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

    Query professionalCollection = FirebaseFirestore.instance
        .collection("professionals")
        .where("uid", isEqualTo: user.uid);
    print(user.uid);
    return StreamBuilder<QuerySnapshot>(
        stream: professionalCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('ALGO SALIO MAL');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingScreen();
          }

          Profesional profesional = profesionalMapToList(snapshot)[0];
          _image = profesional.foto;
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
                      padding: EdgeInsets.only(top: size.height * 0.51),
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
        });
  }

  Widget cabeceraPerfilProfesional(Size size, Profesional profesional) {
    return Stack(
      children: <Widget>[
        // Draw oval Shape
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: size.height * 0.54,
            width: double.infinity,
            color: kRosado,
          ),
        ),
        Column(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: size.height * 0.04),
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
                          : Image.network(
                              _image,
                              width: 200,
                              height: 200,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes
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
                    left: (size.width / 2) * 0.55,
                  ),
                  alignment: Alignment.topCenter,
                  child: GestureDetector(
                    onTap: () {
                      _showPicker(context, profesional);
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
              padding: EdgeInsets.only(top: 10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          EditProfileProfesional(profesional: profesional)));
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
                padding: EdgeInsets.only(top: 10.0),
                width: size.width * 0.8,
                alignment: Alignment.topCenter,
                child: Text(
                  profesional.nombre + " " + profesional.apellido,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: kNegro,
                    fontSize: (size.height / 2.5) * 0.08,
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
          _sectionButton(),
          _section('Correo', profesional.correo),
          _section('Ciudad', profesional.ciudad ?? ''),
          _section('Especialidad', profesional.especialidad ?? ''),
          _section('Descripcion', profesional.descripcion ?? ''),
          _section('Experiencia', profesional.experiencia ?? ''),
          _sectionList('Proyectos', profesional.proyectos, size ?? ['']),
          _sectionList('Convenio', profesional.convenios, size ?? ['']),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(right: 15.0, left: 15.0),
            child: Text(
              "Información Bancaria",
              style: TextStyle(
                fontSize: 23.0,
                color: kRojoOscuro,
                fontFamily: 'PoppinsRegular',
              ),
              textAlign: TextAlign.start,
            ),
          ),
          _section('Banco', profesional.banco.banco ?? " "),
          _section('Número de Cuenta', profesional.banco.numCuenta ?? " "),
          _section('Tipo de Cuenta', profesional.banco.tipoCuenta ?? " "),
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

  // Change password popup dialog
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
