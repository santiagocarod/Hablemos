import 'package:flutter/material.dart';
import 'package:hablemos/model/cita.dart';
import 'package:intl/intl.dart';

//Screen of date details
class DateDetails extends StatelessWidget {
  final Cita cita;

  DateDetails({Key key, @required this.cita}) : super(key: key);

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
          _header(context, size, cita),
        ],
      ),
    );
  }
}

// Header of the screen arrow, center text and white box
Widget _header(BuildContext context, Size size, Cita cita) {
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
                  Icons.keyboard_arrow_left,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'inicio');
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
          _boxInfo(context, size, cita),
        ],
      ),
    ),
  );
}

// White Box wich contains all de information
Widget _boxInfo(BuildContext context, Size size, Cita cita) {
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
          _name(context, cita),
          _hour(context, cita),
          _date(context, cita),
          _cost(context, cita),
          _payment(context, cita),
          _place(context, cita),
          _specialty(context, cita),
          _type(context, cita),
          _contact(context, cita),
          _state(context, cita),
          _buttons(context),
        ],
      ),
    ),
  );
}

// Name of the professional and edit button
Widget _name(BuildContext context, Cita cita) {
  final String text = cita.uidProfesional.toString();
  return Stack(
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 75.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.place,
              size: 24,
              color: Colors.black,
            ),
            Text(
              'Cita con $text',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontFamily: 'PoppinsRegular',
              ),
            ),
          ],
        ),
      ),
      _editButton(context),
    ],
  );
}

// Edit button
Widget _editButton(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 260.0, right: 0.0),
    child: Icon(
      Icons.edit_outlined,
      size: 47,
      color: Colors.black,
    ),
  );
}

// Hour of the date
Widget _hour(BuildContext context, Cita cita) {
  final DateFormat format = DateFormat('hh:mm a');
  final String text = format.format(cita.dateTime);
  return Container(
    width: 270.0,
    height: 46,
    child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Text(
          'Hora:',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.black,
            fontFamily: 'PoppinsRegular',
          ),
        ),
        Column(
          children: <Widget>[
            Text(
              '\n$text',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontFamily: 'PoppinsRegular',
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Container(
                child: Divider(
                  color: Colors.black.withOpacity(0.40),
                  thickness: 3.0,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// Appointment date
Widget _date(BuildContext context, Cita cita) {
  final DateFormat format = DateFormat('dd/mm/yyyy');
  final String text = format.format(cita.dateTime);
  return Container(
    width: 270.0,
    height: 46,
    child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Text(
          'Fecha:',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.black,
            fontFamily: 'PoppinsRegular',
          ),
        ),
        Column(
          children: <Widget>[
            Text(
              '\n$text',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontFamily: 'PoppinsRegular',
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Container(
                child: Divider(
                  color: Colors.black.withOpacity(0.40),
                  thickness: 3.0,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// Cost of date
Widget _cost(BuildContext context, Cita cita) {
  final format = NumberFormat('#,###');
  final String text = format.format(cita.costo);
  return Container(
    width: 270.0,
    height: 46,
    child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Text(
          'Costo:',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.black,
            fontFamily: 'PoppinsRegular',
          ),
        ),
        Column(
          children: <Widget>[
            Text(
              '\n\$$text',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontFamily: 'PoppinsRegular',
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Container(
                child: Divider(
                  color: Colors.black.withOpacity(0.40),
                  thickness: 3.0,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// Payment details
Widget _payment(BuildContext context, Cita cita) {
  return Container(
    width: 270.0,
    height: 46,
    child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Text(
          'Detalles de pago:',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.black,
            fontFamily: 'PoppinsRegular',
          ),
        ),
        Column(
          children: <Widget>[
            Text(
              '\nBancolombia #123123-213-213',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontFamily: 'PoppinsRegular',
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Container(
                child: Divider(
                  color: Colors.black.withOpacity(0.40),
                  thickness: 3.0,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// Place of the date
Widget _place(BuildContext context, Cita cita) {
  final String text = cita.lugar;
  return Container(
    width: 270.0,
    height: 46,
    child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Text(
          'Lugar:',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.black,
            fontFamily: 'PoppinsRegular',
          ),
        ),
        Column(
          children: <Widget>[
            Text(
              '\n$text',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontFamily: 'PoppinsRegular',
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Container(
                child: Divider(
                  color: Colors.black.withOpacity(0.40),
                  thickness: 3.0,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// Specialty of the date
Widget _specialty(BuildContext context, Cita cita) {
  final String text = cita.especialidad;
  return Container(
    width: 270.0,
    height: 46,
    child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Text(
          'Especialidad:',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.black,
            fontFamily: 'PoppinsRegular',
          ),
        ),
        Column(
          children: <Widget>[
            Text(
              '\n$text',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontFamily: 'PoppinsRegular',
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Container(
                child: Divider(
                  color: Colors.black.withOpacity(0.40),
                  thickness: 3.0,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// Type of the date
Widget _type(BuildContext context, Cita cita) {
  final String text = cita.especialidad;
  return Container(
    width: 270.0,
    height: 46,
    child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Text(
          'Tipo:',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.black,
            fontFamily: 'PoppinsRegular',
          ),
        ),
        Column(
          children: <Widget>[
            Text(
              '\n$text',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontFamily: 'PoppinsRegular',
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Container(
                child: Divider(
                  color: Colors.black.withOpacity(0.40),
                  thickness: 3.0,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// Contact information (professional)
Widget _contact(BuildContext context, Cita cita) {
  return Container(
    width: 270.0,
    height: 46,
    child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Text(
          'Contacto:',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.black,
            fontFamily: 'PoppinsRegular',
          ),
        ),
        Column(
          children: <Widget>[
            Text(
              '\n3124153',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontFamily: 'PoppinsRegular',
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Container(
                child: Divider(
                  color: Colors.black.withOpacity(0.40),
                  thickness: 3.0,
                ),
              ),
            ),
          ],
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
