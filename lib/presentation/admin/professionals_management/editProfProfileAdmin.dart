import 'dart:io';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/business/admin/negocioProfesionales.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/util/snapshotConvertes.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/ux/loading_screen.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';

class EditProfileProfessionalAdmin extends StatefulWidget {
  @override
  _EditProfileProfessionalAdminState createState() =>
      _EditProfileProfessionalAdminState();
  final Profesional profesional;
  const EditProfileProfessionalAdmin({this.profesional});
}

class _EditProfileProfessionalAdminState
    extends State<EditProfileProfessionalAdmin> {
  TextEditingController _dateController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _mailController = new TextEditingController();
  TextEditingController _cityController = new TextEditingController();
  TextEditingController _convenioController = new TextEditingController();
  TextEditingController _especialidadController = new TextEditingController();
  TextEditingController _proyectosController = new TextEditingController();
  TextEditingController _experienciaController = new TextEditingController();
  TextEditingController _descripcionController = new TextEditingController();
  TextEditingController _bankNameController = new TextEditingController();
  TextEditingController _accountNumberController = new TextEditingController();
  TextEditingController _accountTypeController = new TextEditingController();

  String _date = '';
  File _image;

  @override
  void initState() {
    super.initState();

    //_dateController = TextEditingController()
    //..text = widget.profesional.fechaNacimiento;

    _mailController = TextEditingController()..text = widget.profesional.correo;
    _cityController = TextEditingController()..text = widget.profesional.ciudad;
    _phoneController = TextEditingController()
      ..text = widget.profesional.celular;
    _nameController = TextEditingController()..text = widget.profesional.nombre;
    _lastNameController = TextEditingController()
      ..text = widget.profesional.apellido;
    _convenioController = TextEditingController()
      ..text = widget.profesional.convenios.toString();
    _proyectosController = TextEditingController()
      ..text = widget.profesional.convenios.toString();
    _experienciaController = TextEditingController()
      ..text = widget.profesional.experiencia;
    _especialidadController = TextEditingController()
      ..text = widget.profesional.especialidad;
    _descripcionController = TextEditingController()
      ..text = widget.profesional.descripcion;
    _bankNameController = TextEditingController()
      ..text = widget.profesional.banco.banco;
    _accountNumberController = TextEditingController()
      ..text = widget.profesional.banco.numCuenta;
    _accountTypeController = TextEditingController()
      ..text = widget.profesional.banco.tipoCuenta;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: kRosado,
      child: SafeArea(
        bottom: false,
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
                  child: _body(size, widget.profesional),
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
                      widget.profesional.banco.toMap();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => _buildDialog(context,
                            widget.profesional, widget.profesional.uid),
                      );
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
                          widget.profesional.nombre = textNombre.text;
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
                          widget.profesional.apellido = textApellido.text;
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

  Widget _body(Size size, Profesional profesional) {
    return Container(
      width: size.width,
      child: Column(
        children: <Widget>[
          _nonEditSection('Correo', _mailController.text ?? ''),
          _editSection('Ciudad', _cityController ?? '', 1),
          _editSection('Teléfono', _phoneController ?? '', 2),
          _editSection(
              'Convenio (Separelos con ";")', _convenioController ?? '', 3),
          _editSection('Especialidad', _especialidadController ?? '', 4),
          _editSection(
              'Proyectos (Separelos con ";")', _proyectosController ?? '', 5),
          _editSection('Experiencia', _experienciaController ?? '', 6),
          _editSection('Descripción', _descripcionController ?? '', 7),
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
          _editSection('Banco', _bankNameController ?? " ", 8),
          _editSection('Número de Cuenta', _accountNumberController ?? " ", 9),
          _editSection('Tipo de Cuenta', _accountTypeController ?? " ", 10),
        ],
      ),
    );
  }

  // Section: title and text field
  Widget _editSection(
      String text, TextEditingController controller, int categoria) {
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
            enableInteractiveSelection: false,
            textAlign: TextAlign.justify,
            onTap: () {
              if (text == 'Fecha de Nacimiento') {
                FocusScope.of(context).requestFocus(new FocusNode());
                _selectDate(context);
              }
            },
            onChanged: (text) {
              controller.text = text;
              controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length));
              if (categoria == 1) {
                widget.profesional.ciudad = controller.text;
              }
              if (categoria == 2) {
                widget.profesional.celular = controller.text;
              }
              if (categoria == 3) {
                widget.profesional.convenios =
                    controller.text.replaceAll("\n", "").split(";");
              }
              if (categoria == 4) {
                widget.profesional.especialidad = controller.text;
              }
              if (categoria == 5) {
                widget.profesional.proyectos =
                    controller.text.replaceAll("\n", "").split(";");
              }
              if (categoria == 6) {
                widget.profesional.experiencia = controller.text;
              }
              if (categoria == 7) {
                widget.profesional.descripcion = controller.text;
              }
              if (categoria == 8) {
                widget.profesional.banco.banco = controller.text;
              }
              if (categoria == 9) {
                widget.profesional.banco.numCuenta = controller.text;
              }
              if (categoria == 10) {
                widget.profesional.banco.tipoCuenta = controller.text;
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
      BuildContext context, Profesional profesional, String usuario) {
    Query citasCollection = FirebaseFirestore.instance
        .collection("appoinments")
        .where("professional.uid", isEqualTo: usuario);

    return StreamBuilder<QuerySnapshot>(
        stream: citasCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('ALGO SALIO MAL');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingScreen();
          }
          List<Cita> citas = citaMapToList(snapshot);
          if (citas.length == 0) {
            return modificacionDialogs(context, profesional);
          } else {
            return modificacionDialogsCita(context, profesional, citas);
          }
        });
  }

  Widget modificacionDialogs(BuildContext context, Profesional profesional) {
    String title2 = "";
    String content2 = "";

    return new AlertDialog(
      title: Text(
        'Confirmación de Modificación',
        style: TextStyle(
          color: kNegro,
          fontSize: 15.0,
          fontFamily: 'PoppinsRegular',
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        '¿Está seguro que desea modificar\neste perfil?',
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
                editarProfesional(profesional).then((value) {
                  actualizarUsuario(profesional);
                  bool state;
                  if (value) {
                    title2 = 'Perfil modificada';
                    content2 = "Su perfil fue modificado exitosamente";
                    state = true;
                  } else {
                    title2 = 'Error de edición';
                    content2 =
                        "Hubo un error guardando los cambios de su perfil, inténtelo nuevamente";
                    state = false;
                  }

                  showDialog(
                    context: context,
                    builder: (BuildContext context) => adviceDialogProfesional(
                        context, title2, content2, state),
                  );
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

  Widget modificacionDialogsCita(
      BuildContext context, Profesional profesional, List<Cita> citas) {
    String title2 = "";
    String content2 = "";
    return new AlertDialog(
      title: Text(
        'Confirmación de Modificación',
        style: TextStyle(
          color: kNegro,
          fontSize: 15.0,
          fontFamily: 'PoppinsRegular',
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        '¿Está seguro que desea modificar\neste perfil?',
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
                citas.forEach((element) {
                  actualizarProfesionalCita(profesional, element);
                });
                editarProfesional(profesional).then((value) {
                  actualizarUsuario(profesional);
                  bool state;
                  if (value) {
                    title2 = 'Perfil modificada';
                    content2 = "Este perfil fue modificado exitosamente";
                    state = true;
                  } else {
                    title2 = 'Error de edición';
                    content2 =
                        "Hubo un error guardando los cambios de este perfil, inténtelo nuevamente";
                    state = false;
                  }

                  showDialog(
                    context: context,
                    builder: (BuildContext context) => adviceDialogProfesional(
                        context, title2, content2, state),
                  );
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

  // Confirm popup dialog
  Widget adviceDialogProfesional(
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

  //Section non editable
  Widget _nonEditSection(String title, String content) {
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
