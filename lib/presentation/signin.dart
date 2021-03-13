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
  String _city = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBar("Registro", null, 0, null),
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/yellowBack.png',
            alignment: Alignment.center,
            fit: BoxFit.fill,
            width: size.width,
            height: size.height,
          ),
          _signinForm(context),
        ],
      ),
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

  void _updateCity(String city) {
    setState(() {
      _city = city;
    });
  }

  Widget _signinForm(BuildContext context) {
    final bloc = InhWidget.of(context);
    return Padding(
      padding: EdgeInsets.only(top: 100.0),
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
                            'Escriba su ciudad',
                            'Ciudad residencia',
                            Icons.location_on,
                            _updateCity,
                            _city), //Input para el ciudad
                        SizedBox(height: 20.0),
                        _crearEdad(context), //Input crear edad
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
      lastDate: new DateTime(2025),
    );

    var myFormat = DateFormat('d-MM-yyyy');

    if (picked != null) {
      setState(() {
        _date = myFormat.format(picked).toString();
        _inputFieldDateController.text = _date;
      });
    }
  }

  signInLogic(dynamic bloc, BuildContext context) {
    final CollectionReference usersRef =
        FirebaseFirestore.instance.collection("users");
    AuthService authService = new AuthService();
    Future<String> user = authService.signUp(bloc.email, bloc.password);
    if (_name == '') {
      showAlertDialog(context, "Por Favor Ingresa tu Nombre");
    } else if (_lastName == '') {
      showAlertDialog(context, "Por Favor Ingresa tu Nombre");
    } else if (_city == '') {
      showAlertDialog(context, "Por Favor Ingresa tu Ciudad");
    } else {
      user.then((value) {
        if (value[0] == "[") {
          showAlertDialog(context, "Hubo un error\nCorreo ya registrado");
        } else {
          usersRef
              .add({
                'name': this._name,
                'lastName': this._lastName,
                'role': 'pacient',
                'uid': value
              })
              .then((value) => Navigator.pushNamed(context, 'inicio'))
              .catchError((value) => showAlertDialog(
                  context, "Hubo un error\nPor Favor intentalo mas tarde"));
          //
        }
      });
    }
  }
}
