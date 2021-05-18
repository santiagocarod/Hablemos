import 'package:flutter/material.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:intl/intl.dart';
import 'package:hablemos/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../inh_widget.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _inputFieldDateController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _telephoneController = new TextEditingController();
  TextEditingController _cityController = new TextEditingController();
  TextEditingController _nameContactController = new TextEditingController();
  TextEditingController _telephoneContactController =
      new TextEditingController();
  TextEditingController _relationContactController =
      new TextEditingController();

  String _date = '';
  DateTime _fecha;

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
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: crearAppBar("Registro", null, 0, null, context: context),
            body: Stack(
              children: <Widget>[
                _signinForm(context, size),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _signinForm(BuildContext context, Size size) {
    final bloc = InhWidget.of(context);
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.025),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 50.0),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 40.0),
                          child: TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.person,
                                color: Colors.yellow[700],
                              ),
                              hintText: 'Escriba su nombre',
                              labelText: 'Nombre',
                            ),
                          ),
                        ), //Input para el nombre
                        SizedBox(height: 20.0),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 40.0),
                          child: TextField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.person,
                                color: Colors.yellow[700],
                              ),
                              hintText: 'Escriba sus apellidos',
                              labelText: 'Apellidos',
                            ),
                          ),
                        ), //Input para el apellido
                        SizedBox(height: 20.0),
                        emailTextBox(bloc), //Input para el email
                        SizedBox(height: 20.0),
                        passwordTextBox(bloc), //Input para el contraseña
                        SizedBox(height: 20.0),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 40.0),
                          child: TextField(
                            controller: _telephoneController,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.call,
                                color: Colors.yellow[700],
                              ),
                              hintText: 'Escriba su teléfono',
                              labelText: 'Teléfono',
                            ),
                          ),
                        ), //Input para el telefono
                        SizedBox(height: 20.0),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 40.0),
                          child: TextField(
                            controller: _cityController,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.location_on,
                                color: Colors.yellow[700],
                              ),
                              hintText: 'Escriba su Ciudad',
                              labelText: 'Ciudad de residencia',
                            ),
                          ),
                        ), //Input para el ciudad
                        SizedBox(height: 20.0),
                        _crearEdad(context),
                        SizedBox(height: 20.0),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 40.0),
                          child: TextField(
                            controller: _nameContactController,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.person,
                                color: Colors.yellow[700],
                              ),
                              hintText: 'Nombre de contacto de emergencia',
                              labelText: 'Nombre Contacto',
                            ),
                          ),
                        ), //Datos Adicionales
                        SizedBox(height: 20.0),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 40.0),
                          child: TextField(
                            controller: _telephoneContactController,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.call,
                                color: Colors.yellow[700],
                              ),
                              hintText: 'Teléfono contacto emergencia',
                              labelText: 'Teléfono de contacto',
                            ),
                          ),
                        ), //Datos Adicionales
                        SizedBox(height: 20.0),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 40.0),
                          child: TextField(
                            controller: _relationContactController,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.supervised_user_circle_outlined,
                                color: Colors.yellow[700],
                              ),
                              hintText: 'Parentesco contacto emergencia',
                              labelText: 'Parentesco Contacto',
                            ),
                          ),
                        ), //Datos Adicionales
                        SizedBox(height: 30.0),
                        iconButtonBigBloc("Crear Cuenta", () {
                          signInLogic(bloc, context);
                        }, Icons.login, Colors.yellow[700],
                            bloc), //IconButton para el boton
                        SizedBox(height: 50.0),
                        textoFinalRojo(
                            'Todos los campos son obligatorios'), //Texto final
                        SizedBox(height: 50.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _crearEdad(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: TextField(
        controller: _inputFieldDateController,
        enableInteractiveSelection: false,
        decoration: InputDecoration(
          icon: Icon(
            Icons.date_range,
            color: Colors.yellow[700],
          ),
          hintText: 'Fecha de nacimiento',
          labelText: 'Fecha de nacimiento',
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDate(context);
        },
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1945),
      lastDate: DateTime.now(),
    );

    var myFormat = DateFormat('d-MM-yyyy');

    if (picked != null) {
      setState(() {
        _date = myFormat.format(picked).toString();
        _fecha = picked;
        _inputFieldDateController.text = _date;
      });
    }
  }

  signInLogic(dynamic bloc, BuildContext context) {
    final CollectionReference usersRef =
        FirebaseFirestore.instance.collection("users");
    final CollectionReference pacienteRef =
        FirebaseFirestore.instance.collection("pacients");

    DateTime today = DateTime.now();
    DateTime birthDate = _fecha;
    int yearDiff = today.year - birthDate.year;
    int monthDiff = today.month - birthDate.month;
    int dayDiff = today.day - birthDate.day;

    if (yearDiff > 18 || yearDiff == 18 && monthDiff >= 0 && dayDiff >= 0) {
      if (_nameController.text == '') {
        showAlertDialog(context, "Por Favor Ingresa tu Nombre.");
      } else if (_lastNameController.text == '') {
        showAlertDialog(context, "Por Favor Ingresa tu Nombre.");
      } else if (_cityController.text == '') {
        showAlertDialog(context, "Por Favor Ingresa tu Ciudad.");
      } else if (_inputFieldDateController.text == '') {
        showAlertDialog(context, "Por Favor Ingresa tu\nFecha de Nacimiento.");
      } else if (_telephoneController.text == '') {
        showAlertDialog(context, "Por Favor Ingresa tu Teléfono.");
      } else if (_telephoneContactController.text == '') {
        showAlertDialog(context,
            "Por Favor Ingresa el Teléfono \nde tu Contacto de Emergencia.");
      } else if (_nameContactController.text == '') {
        showAlertDialog(context,
            "Por Favor Ingresa el Nombre \nde tu Contacto de Emergencia.");
      } else {
        AuthService authService = new AuthService();
        Future<String> user = authService.signUp(bloc.email, bloc.password,
            '${_nameController.text} ${_lastNameController.text}');
        user.then((value) {
          if (value[0] == "[") {
            showAlertDialog(context, "Hubo un error\n Correo ya registrado.");
          } else {
            usersRef
                .doc(value)
                .set({
                  'role': 'pacient',
                  'name': _nameController.text,
                })
                .then((value) => Navigator.pushNamed(context, 'verifyEmail',
                    arguments: bloc.email))
                .catchError((value) => showAlertDialog(
                    context, "Hubo un error\nPor Favor intentalo mas tarde"));

            pacienteRef.doc(value).set({
              'name': _nameController.text,
              'lastName': _lastNameController.text,
              'city': _cityController.text,
              'email': bloc.email,
              'birthDate': _inputFieldDateController.text,
              'picture': 'falta foto',
              'phone': _telephoneController.text,
              'emergencyContactName': _nameContactController.text,
              'emergencyContactPhone': _telephoneContactController.text,
              'emergencyContactRelationship': _relationContactController.text,
              'uid': value,
            }).catchError((value) => showAlertDialog(
                context, "Hubo un Error\nPor Favor intentalo mas tarde"));
          }
        });
      }
    } else {
      if (_nameController.text == '') {
        showAlertDialog(context, "Por Favor Ingresa tu Nombre.");
      } else if (_lastNameController.text == '') {
        showAlertDialog(context, "Por Favor Ingresa tu Nombre.");
      } else if (_cityController.text == '') {
        showAlertDialog(context, "Por Favor Ingresa tu Ciudad.");
      } else if (_inputFieldDateController.text == '') {
        showAlertDialog(context, "Por Favor Ingresa tu\nFecha de Nacimiento.");
      } else if (_telephoneController.text == '') {
        showAlertDialog(context, "Por Favor Ingresa tu Teléfono.");
      } else if (_telephoneContactController.text == '') {
        showAlertDialog(context,
            "Por Favor Ingresa el Teléfono \nde tu Contacto de Emergencia.");
      } else if (_nameContactController.text == '') {
        showAlertDialog(context,
            "Por Favor Ingresa el Nombre \nde tu Contacto de Emergencia.");
      } else {
        List<String> usuario = [];
        usuario.add(_nameController.text);
        usuario.add(_lastNameController.text);
        usuario.add(_cityController.text);
        usuario.add(bloc.email);
        usuario.add(_inputFieldDateController.text);
        usuario.add(bloc.password);
        usuario.add(_nameContactController.text);
        usuario.add(_telephoneContactController.text);
        usuario.add(_relationContactController.text);
        usuario.add(_telephoneController.text);

        Navigator.pushNamed(context, 'registroMenorEdad', arguments: usuario);
      }
    }
  }
}
