import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/services/auth.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:image_picker/image_picker.dart';

import '../constants.dart';

class SingInMinor extends StatefulWidget {
  @override
  _SingInMinorState createState() => _SingInMinorState();
}

class _SingInMinorState extends State<SingInMinor> {
  File _image;
  final ImagePicker _imagePicker = new ImagePicker();
  int selectRadio;
  int selectRadioAuto;

  setSelectedRadio(int val) {
    setState(() {
      selectRadio = val;
    });
  }

  getSelectedRadio() {
    return selectRadio;
  }

  _imagenDesdeCamara() async {
    PickedFile image = await _imagePicker.getImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = File(image.path);
    });
  }

  _imagenDesdeGaleria() async {
    PickedFile image = await _imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(image.path);
    });
  }

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
                        //Navigator.of(context).pop();
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
    return Stack(
      children: [
        Container(
          child: Image.asset(
            'assets/images/yellowBack.png',
            alignment: Alignment.center,
            fit: BoxFit.fill,
            width: size.width,
            height: size.height,
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: crearAppBar("Autorización", null, 0, null),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: kAzulOscuro,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    height: 180.0,
                    child: Center(
                      child: Text(
                        "¡Como es menor de edad debe escoger entre subir una autorización firmada por sus padres o permitir que su contacto de emergencia sea contactado para que pueda hacer uso de la aplicación!",
                        style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          color: kBlanco,
                          fontSize: 16.0,
                          decoration: TextDecoration.none,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  RadioListTile(
                    value: 1,
                    groupValue: selectRadio,
                    title: Text("Autorización Llamada"),
                    subtitle:
                        Text("Autoriza llamada a su contacto de Emergencia"),
                    activeColor: kRojoOscuro,
                    onChanged: (val) {
                      setSelectedRadio(val);
                      _image = null;
                    },
                    selected: false,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  RadioListTile(
                    value: 2,
                    groupValue: selectRadio,
                    title: Text("Autorización Firmada"),
                    subtitle: Text("Subir Carta de Autorización"),
                    activeColor: kRojoOscuro,
                    onChanged: (val) {
                      setSelectedRadio(val);
                    },
                    secondary: OutlinedButton(
                      child: Text("Subir"),
                      onPressed: () {
                        _showPicker(context);
                      },
                    ),
                    selected: false,
                  ),
                  _image == null
                      ? SizedBox(
                          height: 10,
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16),
                          child: Image.file(
                            _image,
                            fit: BoxFit.fill,
                          ),
                        ),
                  _crearCuenta(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buttonAutorizacion(
      String text, Function function, IconData iconData, Color color) {
    return GestureDetector(
      onTap: function,
      child: Container(
        alignment: Alignment.center,
        width: 280.0,
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.yellow[700],
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 5,
                color: Colors.grey.withOpacity(0.5)),
          ],
        ),
        child: Text(
          '$text',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "PoppinsRegular",
              fontSize: 18,
              color: kBlanco,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _crearCuenta(BuildContext context) {
    final CollectionReference usersRef =
        FirebaseFirestore.instance.collection("users");
    final CollectionReference pacienteRef =
        FirebaseFirestore.instance.collection("pacients");

    final List<String> usuario = ModalRoute.of(context).settings.arguments;

    final String nombre = usuario[0];
    final String apellido = usuario[1];
    final String correo = usuario[3];
    final String fechaNacimiento = usuario[4];
    final String ciudad = usuario[2];
    final String contrasena = usuario[5];
    final String nombreContacto = usuario[6];
    final String telefonoContacto = usuario[7];
    final String relacionContacto = usuario[8];
    final String telefono = usuario[9];

    if (selectRadio == 1) {
      return GestureDetector(
        onTap: () {
          AuthService authService = new AuthService();
          Future<String> user =
              authService.signUp(correo, contrasena, "nombre apellido");
          user.then((value) {
            if (value[0] == "[") {
              showAlertDialog(context, "Hubo un error\nCorreo ya registrado");
            } else {
              usersRef
                  .doc(value)
                  .set({
                    'role': 'pacient',
                    'name': nombre,
                  })
                  .then((value) => Navigator.pushNamed(context, 'inicio'))
                  .catchError((value) => showAlertDialog(
                      context, "Hubo un error\nPor Favor intentalo mas tarde"));

              pacienteRef.doc(value).set({
                'name': nombre,
                'lastName': apellido,
                'city': ciudad,
                'email': correo,
                'birthDate': fechaNacimiento,
                'picture': 'falta foto',
                'autorizacion': "llamada",
                'phone': telefono,
                'emergencyContactName': nombreContacto,
                'emergencyContactPhone': telefonoContacto,
                'emergencyContactRelationship': relacionContacto,
                'uid': value,
              }).catchError((value) => showAlertDialog(
                  context, "Hubo un error\nPor Favor intentalo mas tarde"));
            }
          });
        },
        child: Container(
          margin: EdgeInsets.only(top: 30.0),
          alignment: Alignment.center,
          width: 280.0,
          height: 60.0,
          decoration: BoxDecoration(
            color: Colors.yellow[700],
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 5,
                  color: Colors.grey.withOpacity(0.5)),
            ],
          ),
          child: Text(
            "Guardar",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "PoppinsRegular",
                fontSize: 18,
                color: kBlanco,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w600),
          ),
        ),
      );
    } else if (selectRadio == 2) {
      return GestureDetector(
        onTap: () {
          AuthService authService = new AuthService();
          Future<String> user =
              authService.signUp(correo, contrasena, "nombre apellido");
          user.then((value) {
            if (value[0] == "[") {
              showAlertDialog(context, "Hubo un error\nCorreo ya registrado");
            } else {
              usersRef
                  .doc(value)
                  .set({
                    'role': 'pacient',
                    'name': nombre,
                  })
                  .then((value) => Navigator.pushNamed(context, 'inicio'))
                  .catchError((value) => showAlertDialog(
                      context, "Hubo un error\nPor Favor intentalo mas tarde"));

              pacienteRef.doc(value).set({
                'name': nombre,
                'lastName': apellido,
                'city': ciudad,
                'email': correo,
                'birthDate': fechaNacimiento,
                'picture': 'falta foto',
                'autorizacion': "_image",
                'phone': telefono,
                'emergencyContactName': nombreContacto,
                'emergencyContactPhone': telefonoContacto,
                'emergencyContactRelationship': relacionContacto,
              }).catchError((value) => showAlertDialog(
                  context, "Hubo un error\nPor Favor intentalo mas tarde"));
            }
          });
        },
        child: Container(
          margin: EdgeInsets.only(top: 30.0, bottom: 30.0),
          alignment: Alignment.center,
          width: 280.0,
          height: 60.0,
          decoration: BoxDecoration(
            color: Colors.yellow[700],
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 5,
                  color: Colors.grey.withOpacity(0.5)),
            ],
          ),
          child: Text(
            "Guardar",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "PoppinsRegular",
                fontSize: 18,
                color: kBlanco,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w600),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 10.0,
      );
    }
  }
}
