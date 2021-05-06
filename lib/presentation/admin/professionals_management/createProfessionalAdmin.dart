import 'dart:io';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/business/admin/negocioProfesionales.dart';
import 'package:hablemos/model/banco.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/services/auth.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';

class CreateProfileProfessionalAdmin extends StatefulWidget {
  @override
  _CreateProfileProfessionalAdmin createState() =>
      _CreateProfileProfessionalAdmin();
  final Profesional profesional;
  const CreateProfileProfessionalAdmin({this.profesional});
}

class _CreateProfileProfessionalAdmin
    extends State<CreateProfileProfessionalAdmin> {
  TextEditingController _dateController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _mailController = new TextEditingController();
  TextEditingController _cityController = new TextEditingController();
  TextEditingController _convenioController = new TextEditingController();
  TextEditingController _especialidadController = new TextEditingController();
  TextEditingController _proyectosController = new TextEditingController();
  TextEditingController _experienciaController = new TextEditingController();
  TextEditingController _descripcionController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _bankNameController = new TextEditingController();
  TextEditingController _accountNumberController = new TextEditingController();
  TextEditingController _accountTypeController = new TextEditingController();
  TextEditingController _telephoneController = new TextEditingController();

  String _date = '';
  File _image;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController()..text = "Nombre";
    _lastNameController = TextEditingController()..text = "Apellido";
    _passwordController = TextEditingController()..text = "123456";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: kRosado,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          // Create an empty appBar, display the arrow back
          appBar: crearAppBar('', null, 0, null),
          body: Stack(
            children: <Widget>[
              cabeceraPerfilProfesional(
                  size, _nameController, _lastNameController),
              Container(
                padding: EdgeInsets.only(top: size.height * 0.53),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: _body(size),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cabeceraPerfilProfesional(Size size, TextEditingController textNombre,
      TextEditingController textApellido) {
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
                      if (_nameController.text != "Nombre" &&
                          _lastNameController.text != "Apellido" &&
                          _mailController.text.isNotEmpty &&
                          _cityController.text.isNotEmpty) {
                        Banco banco = new Banco(
                            banco: _bankNameController.text,
                            numCuenta: _accountNumberController.text,
                            tipoCuenta: _accountTypeController.text);
                        Profesional prof = new Profesional(
                            nombre: _nameController.text,
                            apellido: _lastNameController.text,
                            fechaNacimiento: _dateController.text,
                            especialidad: _especialidadController.text,
                            correo: _mailController.text,
                            ciudad: _cityController.text,
                            experiencia: _experienciaController.text,
                            descripcion: _descripcionController.text,
                            celular: _telephoneController.text,
                            banco: banco,
                            proyectos: _proyectosController.text
                                .replaceAll("\n", "")
                                .split(";"),
                            convenios: _convenioController.text
                                .replaceAll("\n", "")
                                .split(";"));

                        String password =
                            _nameController.text + _passwordController.text;

                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _buildDialog(context, prof, password),
                        );
                      } else {
                        print(_nameController.text);
                        print(_lastNameController.text);
                        print(_mailController.text);
                        print(_cityController.text);
                        print("nose pudo");
                      }
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.check,
                          size: 20.0,
                          color: kNegro,
                        ),
                        Text(
                          ' Guardar',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topCenter,
                      child: AutoSizeTextField(
                        controller: textNombre,
                        textAlign: TextAlign.center,
                        enableInteractiveSelection: false,
                        fullwidth: false,
                        style: TextStyle(
                          color: kNegro,
                          fontSize: (size.height / 2) * 0.06,
                          fontFamily: 'PoppinsRegular',
                        ),
                        onChanged: (text) {
                          textNombre.text = text;
                          textNombre.selection = TextSelection.fromPosition(
                              TextPosition(offset: textNombre.text.length));
                        },
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Container(
                      alignment: Alignment.topCenter,
                      child: AutoSizeTextField(
                        controller: textApellido,
                        textAlign: TextAlign.center,
                        enableInteractiveSelection: false,
                        fullwidth: false,
                        style: TextStyle(
                          color: kNegro,
                          fontSize: (size.height / 2) * 0.06,
                          fontFamily: 'PoppinsRegular',
                        ),
                        onChanged: (text) {
                          textApellido.text = text;
                          textApellido.selection = TextSelection.fromPosition(
                              TextPosition(offset: textApellido.text.length));
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
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

  Widget _body(Size size) {
    return Container(
      width: size.width,
      child: Column(
        children: <Widget>[
          _nonEditSection('Contraseña', _nameController, _passwordController),
          _editSection('Correo', _mailController),
          _editSection('Ciudad', _cityController),
          _editSection('Teléfono', _telephoneController ?? ''),
          _editSection(
              'Convenios (Separelos con ";")', _convenioController ?? ['']),
          _editSection('Especialidad', _especialidadController ?? ''),
          _editSection(
              'Proyectos (Separelo con ";")', _proyectosController ?? ['']),
          _editSection('Experiencia', _experienciaController ?? ''),
          _editSection('Descripción', _descripcionController ?? ''),
          _editSection('Fecha de Nacimiento', _dateController ?? ''),
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
          _editSection('Banco', _bankNameController ?? ''),
          _editSection('Número de Cuenta', _accountNumberController ?? ''),
          _editSection('Tipo de Cuenta', _accountTypeController ?? ''),
          SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }

  //Section non editable
  Widget _nonEditSection(String title, TextEditingController _nameController,
      TextEditingController _passwordController) {
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
            "La contraseña de este profesional sera su nombre más 123456, Ej: Diana123456",
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

  // Section: Password
  Widget _editSection(String text, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.only(right: 15.0, left: 15.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              fontSize: 20.0,
              color: kRojoOscuro,
              fontFamily: 'PoppinsRegular',
            ),
            textAlign: TextAlign.left,
          ),
          TextField(
            controller: controller,
            maxLines: 10,
            minLines: 1,
            enableInteractiveSelection: false,
            textAlign: TextAlign.justify,
            onTap: () {
              if (text == 'Fecha de Nacimiento') {
                FocusScope.of(context).requestFocus(new FocusNode());
                _selectDate(context);
              }
            },
          ),
        ],
      ),
    );
  }

  // Picker Date
  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1945),
      lastDate: new DateTime(2025),
    );
    var myFormat = DateFormat('d/MM/yyyy');
    if (picked != null) {
      setState(() {
        _date = myFormat.format(picked).toString();
        _dateController.text = _date;
      });
    }
  }

  // Confirm popup dialog
  Widget _buildDialog(
      BuildContext context, Profesional profesional, String password) {
    String title = "";
    String content = "";
    return new AlertDialog(
      title: Text(
        'Confirmación de Creaasción',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kNegro,
          fontSize: 15.0,
          fontFamily: 'PoppinsRegular',
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        '¿Estás seguro que deseas crear\neste nuevo profesional?',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kNegro,
          fontSize: 14.0,
          fontFamily: 'PoppinsRegular',
        ),
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
                String nombre = profesional.nombre;
                final CollectionReference usersRef =
                    FirebaseFirestore.instance.collection("users");
                AuthService authService = new AuthService();
                Future<String> user = authService.signUp(profesional.correo,
                    password, '$nombre ${profesional.apellido}');
                user.then((value) {
                  if (value[0] == "[") {
                    showAlertDialog(
                        context, "Hubo un error\nCorreo ya registrado");
                  } else {
                    usersRef
                        .doc(value)
                        .set({
                          'role': 'professional',
                          'name': nombre,
                        })
                        .then((value) => Navigator.pushNamed(
                            context, 'adminManageProffessional'))
                        .catchError((value) => showAlertDialog(context,
                            "Hubo un error\nPor Favor intentalo mas tarde"));

                    agregarProfesional(profesional, value).then((value) {
                      bool state;
                      if (value) {
                        title = 'Profesional Creado ';
                        content = "Su profesional ha sido creado exitosamente.";
                        state = true;
                      } else {
                        title = 'Error de Creación';
                        content =
                            "Hubo un error creando el profesional, inténtelo nuevamente";
                        state = false;
                      }
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => _adviceDialog(
                                context,
                                title,
                                content,
                                state,
                              ));
                    });
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

  Widget _adviceDialog(
      BuildContext context, String text, String content, bool state) {
    return new AlertDialog(
      title: Text(text),
      content: Text(content),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: kNegro, width: 2.0),
      ),
      actions: <Widget>[
        Center(
          child: ElevatedButton(
            onPressed: () {
              if (state) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              } else if (!state) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(378.0),
                side: BorderSide(color: kNegro),
              ),
              shadowColor: Colors.black,
            ),
            child: const Text(
              'Cerrar',
              style: TextStyle(
                color: kNegro,
                fontSize: 14.0,
                fontFamily: 'PoppinsRegular',
              ),
            ),
          ),
        ),
      ],
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
}
