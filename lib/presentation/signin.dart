import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _inputFieldDateController = new TextEditingController();
  String _date = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //_crearFondo(),
          _signinForm(context),
        ],
      ),
    );
  }

  Widget _signinForm(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 50.0,
              width: double.infinity,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_left,
                        size: 40,
                      ),
                      onPressed: () {},
                    ),
                    Text(
                      'Registro',
                      style: TextStyle(
                        fontSize: 26.0,
                      ),
                    ),
                    SizedBox(width: 50.0)
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50.0),
                      _crearNombre(),
                      SizedBox(height: 20.0),
                      _crearApellido(),
                      SizedBox(height: 20.0),
                      _crearCorreo(),
                      SizedBox(height: 20.0),
                      _crearContra(),
                      SizedBox(height: 20.0),
                      _crearCiudad(),
                      SizedBox(height: 20.0),
                      _crearEdad(context),
                      SizedBox(height: 30.0),
                      _crearBoton(),
                      SizedBox(height: 50.0),
                      _crearTextoObligatorio(),
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

  Widget _crearNombre() {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.black,
      ),
      child: Container(
        child: TextField(
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            hintText: 'Escriba su nombre',
            labelText: 'Nombre',
            labelStyle: TextStyle(
              color: Colors.blue[600],
            ),
            isDense: true,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _crearApellido() {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.black,
      ),
      child: Container(
        child: TextField(
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            hintText: 'Escriba su apellidos',
            labelText: 'Apellidos',
            labelStyle: TextStyle(
              color: Colors.blue[600],
            ),
            isDense: true,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _crearCorreo() {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.black,
      ),
      child: Container(
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            hintText: 'Escriba su correo',
            labelText: 'Correo Electrónico',
            labelStyle: TextStyle(
              color: Colors.blue[600],
            ),
            isDense: true,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _crearContra() {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.black,
      ),
      child: Container(
        child: TextField(
          obscureText: true,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            hintText: 'Escriba su contraseña',
            labelText: 'Contraseña',
            labelStyle: TextStyle(
              color: Colors.blue[600],
            ),
            isDense: true,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _crearCiudad() {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.black,
      ),
      child: Container(
        child: TextField(
          obscureText: true,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            hintText: 'Escriba su ciudad',
            labelText: 'Ciudad residencia',
            labelStyle: TextStyle(
              color: Colors.blue[600],
            ),
            isDense: true,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _crearEdad(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.black,
      ),
      child: Container(
        child: TextField(
          controller: _inputFieldDateController,
          enableInteractiveSelection: false,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Fecha de nacimiento',
            labelText: 'Fecha de nacimiento',
            labelStyle: TextStyle(
              color: Colors.blue[600],
            ),
            isDense: true,
          ),
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            _selectDate(context);
          },
        ),
      ),
    );
  }

  Widget _crearBoton() {
    return ElevatedButton(
      onPressed: () {},
      child: Container(
        height: 50,
        child: Center(
          child: Text(
            'Crear Cuenta',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Color.fromRGBO(252, 208, 107, 1),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget _crearTextoObligatorio() {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(228, 88, 101, 0.5),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      height: 80.0,
      child: Center(
        child: Text(
          'Todos los campos son obligatorios',
          style: TextStyle(
            color: Color.fromRGBO(228, 88, 101, 1),
            fontSize: 17.0,
          ),
          textAlign: TextAlign.center,
        ),
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

    if (picked != null) {
      setState(() {
        _date = picked.toString();
        _inputFieldDateController.text = _date;
      });
    }
  }
}
