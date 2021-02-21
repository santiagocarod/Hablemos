import 'package:flutter/material.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/services/providers/profesionales_provider.dart';
import 'package:intl/intl.dart';
import 'package:hablemos/ux/atoms.dart';

//Screen of date details
class DateDetails extends StatelessWidget {
  DateDetails({Key key, @required this.cita}) : super(key: key);
  final Cita cita;
  final Profesional profesional = ProfesionalesProvider.getProfesional();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //Background Image
          Image.asset(
            'assets/images/dateBack.png',
            alignment: Alignment.center,
            fit: BoxFit.fill,
            width: size.width,
            height: size.height,
          ),
          _header(context, size, cita, profesional),
        ],
      ),
    );
  }
}

// Header of the screen arrow, center text and white box
Widget _header(
    BuildContext context, Size size, Cita cita, Profesional profesional) {
  return SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 50.0,
              width: double.infinity,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.keyboard_backspace,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Text(
                'Detalle de Cita',
                style: TextStyle(
                  fontSize: 26.0,
                  color: Colors.black,
                  fontFamily: 'PoppinsRegular',
                ),
              ),
              SizedBox(width: 50.0)
            ],
          ),
          _boxInfo(context, size, cita, profesional),
        ],
      ),
    ),
  );
}

// White Box wich contains all de information
Widget _boxInfo(
    BuildContext context, Size size, Cita cita, Profesional profesional) {
  final DateFormat houformat = DateFormat('hh:mm a');
  final String hour = houformat.format(cita.dateTime);
  final String date = cita.dateTime.day.toString() +
      '/' +
      cita.dateTime.month.toString() +
      '/' +
      cita.dateTime.year.toString();
  final price = NumberFormat('#,###');
  final String pay = '\$' + price.format(cita.costo);
  final String count = profesional.numeroCuenta.toString();
  final String place = cita.lugar;
  final String specialty = cita.especialidad;
  final String type = cita.especialidad;
  final String contact = profesional.celular.toString();

  return SingleChildScrollView(
    child: Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(20),
      height: 599,
      width: 359,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.14),
            spreadRadius: 6,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          _name(context, profesional),
          secction('Hora:', hour),
          secction('Fecha:', date),
          secction('Costo', pay),
          secction('Detalles de pago:', count),
          secction('Lugar:', place),
          secction('Especialidad:', specialty),
          secction('Tipo:', type),
          secction('Contacto:', contact),
          _state(context, cita),
          _buttons(context),
        ],
      ),
    ),
  );
}

// Name of the professional and edit button
Widget _name(BuildContext context, Profesional profesional) {
  final String text = profesional.toString();
  return Container(
    width: 359.0,
    child: Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
          alignment: Alignment.center,
          child: Icon(Icons.location_on),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(
                top: 15.0,
              ),
              child: Icon(Icons.edit, size: 47)),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 40.0, bottom: 20.0),
          child: Text(
            'Cita con $text',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              fontFamily: 'PoppinsRegular',
            ),
          ),
        ),
      ],
    ),
  );
}

// State of the date (aproved or canceled)
Widget _state(BuildContext context, Cita cita) {
  final bool text = cita.estado;
  return Container(
    width: 270.0,
    height: 46,
    child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Text(
          'Estado:\n\n',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.black,
            fontFamily: 'PoppinsRegular',
          ),
        ),
        _selectIcon(text),
      ],
    ),
  );
}

//Select the type of icon (aproved: green check, cancel: red cancel)
Widget _selectIcon(bool text) {
  if (text == false) {
    return Icon(
      Icons.cancel,
      size: 61,
      color: Colors.red,
    );
  } else {
    return Icon(
      Icons.check_circle,
      size: 61,
      color: Colors.green,
    );
  }
}

// Payment and cancel buttons
Widget _buttons(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
    width: 270.0,
    height: 46,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: 126,
          height: 35,
          child: ElevatedButton(
            child: Text(
              "ADJUNTAR PAGO",
              style: TextStyle(
                fontSize: 9.0,
                color: Colors.black,
                letterSpacing: 2,
                fontFamily: 'PoppinSemiBold',
              ),
              textAlign: TextAlign.center,
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(378.0),
              ),
              shadowColor: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
        SizedBox(
          width: 126,
          height: 35,
          child: ElevatedButton(
            child: Text(
              "CANCELAR",
              style: TextStyle(
                fontSize: 9.0,
                color: Colors.black,
                letterSpacing: 2,
                fontFamily: 'PoppinSemiBold',
              ),
              textAlign: TextAlign.center,
            ),
            style: ElevatedButton.styleFrom(
              primary: const Color(0xffE45865),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(378.0),
              ),
              shadowColor: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
      ],
    ),
  );
}
