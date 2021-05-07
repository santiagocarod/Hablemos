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
  String _date = '';
  String _name = '';
  String _lastName = '';
  String _telephone = '';
  String _city = '';
  DateTime _fecha;
  String _nameContact = '';
  String _telephoneContact = '';
  String _relationContact = '';

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

  void _updateName(String name) {
    setState(() {
      _name = name;
    });
  }

  void _updateLastName(String lastName) {
    setState(() {
      _lastName = lastName;
    });
  }

  void _updateTelephone(String telephone) {
    setState(() {
      _telephone = telephone;
    });
  }

  void _updateCity(String city) {
    setState(() {
      _city = city;
    });
  }

  void _updateContactName(String nameC) {
    setState(() {
      _nameContact = nameC;
    });
  }

  void _updateContactTelephone(String telephoneC) {
    setState(() {
      _telephoneContact = telephoneC;
    });
  }

  void _updateContactRelation(String relationC) {
    setState(() {
      _relationContact = relationC;
    });
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
                        InputTextBoxWController(
                            'Escriba su nombre',
                            'Nombre',
                            Icons.person,
                            _updateName,
                            _name), //Input para el nombre
                        SizedBox(height: 20.0),
                        InputTextBoxWController(
                            'Escriba sus apellidos',
                            'Apellidos',
                            Icons.person,
                            _updateLastName,
                            _lastName), //Input para el apellido
                        SizedBox(height: 20.0),
                        emailTextBox(bloc), //Input para el email
                        SizedBox(height: 20.0),
                        passwordTextBox(bloc), //Input para el contraseña
                        SizedBox(height: 20.0),
                        InputTextBoxWController(
                            'Escriba su teléfono',
                            'Teléfono ',
                            Icons.call,
                            _updateTelephone,
                            _telephone),
                        SizedBox(height: 20.0),
                        InputTextBoxWController(
                            'Escriba su ciudad',
                            'Ciudad residencia',
                            Icons.location_on,
                            _updateCity,
                            _city), //Input para el ciudad
                        SizedBox(height: 20.0),
                        _crearEdad(context),
                        SizedBox(height: 20.0),
                        InputTextBoxWController(
                            'Nombre contacto emergencia',
                            'Nombre Contacto ',
                            Icons.person,
                            _updateContactName,
                            _nameContact), //Datos Adicionales
                        SizedBox(height: 20.0),
                        InputTextBoxWController(
                            'Teléfono contacto emergencia',
                            'Teléfono Contacto',
                            Icons.call,
                            _updateContactTelephone,
                            _telephoneContact), //Datos Adicionales
                        SizedBox(height: 20.0),
                        InputTextBoxWController(
                            'Parentesco contacto emergencia',
                            'Parentesco Contacto ',
                            Icons.supervised_user_circle_outlined,
                            _updateContactRelation,
                            _relationContact), //Datos Adicionales
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
      if (_name == '') {
        showAlertDialog(context, "Por Favor Ingresa tu Nombre");
      } else if (_lastName == '') {
        showAlertDialog(context, "Por Favor Ingresa tu Nombre");
      } else if (_city == '') {
        showAlertDialog(context, "Por Favor Ingresa tu Ciudad");
      } else if (_inputFieldDateController.text == '') {
        showAlertDialog(context, "Por Favor Ingresa tu\nFecha de Nacimiento");
      } else if (_telephone == '') {
        showAlertDialog(context, "Por Favor Ingresa tu Teléfono");
      } else if (_telephoneContact == '') {
        showAlertDialog(context,
            "Por Favor Ingresa el Teléfono \nde tu Contacto de Emergencia");
      } else if (_nameContact == '') {
        showAlertDialog(context,
            "Por Favor Ingresa el Nombre \nde tu Contacto de Emergencia");
      } else {
        AuthService authService = new AuthService();
        Future<String> user =
            authService.signUp(bloc.email, bloc.password, '$_name $_lastName');
        user.then((value) {
          if (value[0] == "[") {
            showAlertDialog(context, "Hubo un error\nCorreo ya registrado");
          } else {
            usersRef
                .doc(value)
                .set({
                  'role': 'pacient',
                  'name': _name,
                })
                .then((value) => Navigator.pushNamed(context, 'inicio'))
                .catchError((value) => showAlertDialog(
                    context, "Hubo un error\nPor Favor intentalo mas tarde"));

            pacienteRef.doc(value).set({
              'name': _name,
              'lastName': _lastName,
              'city': _city,
              'email': bloc.email,
              'birthDate': _inputFieldDateController.text,
              'picture': 'falta foto',
              'phone': _telephone,
              'emergencyContactName': _nameContact,
              'emergencyContactPhone': _telephoneContact,
              'emergencyContactRelationship': _relationContact,
              'uid': value,
            }).catchError((value) => showAlertDialog(
                context, "Hubo un error\nPor Favor intentalo mas tarde"));
          }
        });
      }
    } else {
      if (_name == '') {
        showAlertDialog(context, "Por Favor Ingresa tu Nombre");
      } else if (_lastName == '') {
        showAlertDialog(context, "Por Favor Ingresa tu Nombre");
      } else if (_city == '') {
        showAlertDialog(context, "Por Favor Ingresa tu Ciudad");
      } else if (_inputFieldDateController.text == '') {
        showAlertDialog(context, "Por Favor Ingresa tu\nFecha de Nacimiento");
      } else if (_telephone == '') {
        showAlertDialog(context, "Por Favor Ingresa tu Teléfono");
      } else if (_telephoneContact == '') {
        showAlertDialog(context,
            "Por Favor Ingresa el Teléfono \nde tu Contacto de Emergencia");
      } else if (_nameContact == '') {
        showAlertDialog(context,
            "Por Favor Ingresa el Nombre \nde tu Contacto de Emergencia");
      } else {
        List<String> usuario = [];
        usuario.add(_name);
        usuario.add(_lastName);
        usuario.add(_city);
        usuario.add(bloc.email);
        usuario.add(_inputFieldDateController.text);
        usuario.add(bloc.password);
        usuario.add(_nameContact);
        usuario.add(_telephoneContact);
        usuario.add(_relationContact);
        usuario.add(_telephone);

        Navigator.pushNamed(context, 'registroMenorEdad', arguments: usuario);
      }
    }
  }
}
