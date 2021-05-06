import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/ux/atoms.dart';
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
    //_convenioController = TextEditingController()
    //..text = widget.profesional.convenios
    //_proyectosController = TextEditingController()
    //..text = widget.profesional.convenios
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
        child: Scaffold(
          extendBodyBehindAppBar: true,
          // Create an empty appBar, display the arrow back
          appBar: crearAppBar('', null, 0, null),
          body: Stack(
            children: <Widget>[
              cabeceraPerfilProfesional(size, widget.profesional),
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
                      // TODO: Save values in profesional
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildDialog(context),
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

  Widget _body(Size size, Profesional profesional) {
    return Container(
      width: size.width,
      child: Column(
        children: <Widget>[
          _nonEditSection('Correo', _mailController.text ?? ''),
          _editSection('Ciudad', 'Bogotá D.C', _cityController ?? ''),
          _editSection('Teléfono', '', _phoneController ?? ''),
          _editSection('Convenio', profesional.convenios.toString(),
              _convenioController ?? ''),
          _editSection('Especialidad', profesional.especialidad,
              _especialidadController ?? ''),
          _editSection('Proyectos', profesional.proyectos.toString(),
              _proyectosController ?? ''),
          _editSection('Experiencia', profesional.experiencia,
              _experienciaController ?? ''),
          _editSection('Descripción', profesional.descripcion,
              _descripcionController ?? ''),
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
          _editSection('Banco', "", _bankNameController ?? " "),
          _editSection('Número de Cuenta', "", _accountNumberController ?? " "),
          _editSection('Tipo de Cuenta', "", _accountTypeController ?? " "),
        ],
      ),
    );
  }

  // Section: title and text field
  Widget _editSection(
      String text, String hint, TextEditingController controller) {
    Text info = Text(
      hint,
      style: TextStyle(
        fontSize: 15.0,
        color: kNegro,
        fontFamily: 'PoppinsRegular',
      ),
    );
    controller.text = info.data;
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
  Widget _buildDialog(BuildContext context) {
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
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _adviceDialog(context),
                );
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

  Widget _adviceDialog(BuildContext context) {
    return new AlertDialog(
      title: Text('Perfil Actualizado'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: kNegro, width: 2.0),
      ),
      actions: <Widget>[
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
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
