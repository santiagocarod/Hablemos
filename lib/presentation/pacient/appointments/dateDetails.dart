import 'package:flutter/material.dart';
import 'package:hablemos/business/pacient/negocioCitas.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:intl/intl.dart';

//Screen of date details
class DateDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Cita cita = ModalRoute.of(context).settings.arguments;

    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          //Background Image
          child: Image.asset(
            'assets/images/dateBack.png',
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
            appBar:
                crearAppBarEventos(context, 'Detalle de Cita', 'citasPaciente'),
            body: Stack(
              children: <Widget>[
                _boxInfo(context, size, cita),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// White Box wich contains all de information
Widget _boxInfo(BuildContext context, Size size, Cita cita) {
  Profesional profesional = cita.profesional;
  final DateFormat houformat = DateFormat('hh:mm a');
  final String hour = houformat.format(cita.dateTime);
  final String date = cita.dateTime.day.toString() +
      '/' +
      cita.dateTime.month.toString() +
      '/' +
      cita.dateTime.year.toString();
  final price = NumberFormat('#,###');
  final String pay = '\$' + price.format(cita.costo);
  final String count = profesional.banco.numCuenta;
  final String place = cita.lugar;
  final String specialty = cita.especialidad;
  final String type = cita.especialidad;
  final String contact = profesional.celular.toString();

  return Container(
    padding: EdgeInsets.only(top: 80.0),
    alignment: Alignment.center,
    child: SingleChildScrollView(
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
            _name(context, profesional, cita),
            secction(title: 'Hora:', text: hour),
            secction(title: 'Fecha:', text: date),
            secction(title: 'Costo', text: pay),
            secction(title: 'Detalles de pago:', text: count),
            secction(title: 'Lugar:', text: place),
            secction(title: 'Especialidad:', text: specialty),
            secction(title: 'Tipo:', text: type),
            secction(title: 'Contacto:', text: contact),
            _state(context, cita),
            _buttons(context, cita),
          ],
        ),
      ),
    ),
  );
}

// Name of the professional and edit button
Widget _name(BuildContext context, Profesional profesional, Cita cita) {
  final String text = profesional.nombre + " " + profesional.apellido;
  return Container(
    width: 359.0,
    child: Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
          alignment: Alignment.center,
          child: Icon(Icons.location_on),
        ),
        // Edit Button
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'CrearCita', arguments: cita);
          },
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
Widget _buttons(BuildContext context, Cita cita) {
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
            onPressed: () {
              Navigator.pushNamed(context, 'AdjuntarPago');
            },
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
            onPressed: () {
              bool resultado;
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return dialogoConfirmacion(
                        context,
                        "citasPaciente",
                        "Confirmación de Cancelación",
                        "¿Estás seguro que deseas cancelar esta Cita?",
                        cancelarCita,
                        parametro:
                            cita); //TODO: VER COMO PASAR EL PARAMETRO DE LA CITA PARA QUE SEPA QUE CITA ELIMINAR
                  });
            },
          ),
        ),
      ],
    ),
  );
}
