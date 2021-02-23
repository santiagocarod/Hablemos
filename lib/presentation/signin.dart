import 'package:flutter/material.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:intl/intl.dart';

import '../inh_widget.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _inputFieldDateController = new TextEditingController();
  String _date = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBar("Registro"),
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

  Widget _signinForm(BuildContext context) {
    final bloc = InhWidget.of(context);
    return SingleChildScrollView(
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
                      inputTextBox('Escriba su nombre', 'Nombre',
                          Icons.person), //Input para el nombre
                      SizedBox(height: 20.0),
                      inputTextBox('Escriba sus apellidos', 'Apellidos',
                          Icons.person), //Input para el apellido
                      SizedBox(height: 20.0),
                      emailTextBox(bloc), //Input para el email
                      SizedBox(height: 20.0),
                      passwordTextBox(bloc), //Input para el contraseña
                      SizedBox(height: 20.0),
                      inputTextBox('Escriba su ciudad', 'Ciudad residencia',
                          Icons.location_on), //Input para el ciudad
                      SizedBox(height: 20.0),
                      _crearEdad(context), //Input crear edad
                      SizedBox(height: 30.0),
                      iconButtonBig("Crear Cuenta", () {}, Icons.login,
                          Colors.yellow[700], bloc), //IconButton para el boton
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
}
