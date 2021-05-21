import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/business/pacient/negocioCitas.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:intl/intl.dart';

/// Clase encargada de mostrar los detalles especificos de una [Cita].
///
/// Ademas redirige a la pantalla para adjuntar pago y editar la información
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

/// Caja blanca base en donde se va a pintar la información
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
  final String count = profesional.banco.toString();
  final String place = cita.lugar;
  final String specialty = cita.especialidad;
  final String type = cita.tipo;
  final String contact = profesional.celular.toString();

  return Container(
    padding: EdgeInsets.only(top: 80.0),
    alignment: Alignment.center,
    child: SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(20),
        height: 620,
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
            secction(title: 'Detalles de pago:', text: count, banco: true),
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

/// Nombre del Profesional y boton de edición de Cita.
///
/// En caso de que se haga click sobre el nombre el Paciente sera redirigido a la pantalla de [ProfessionalDetails()]
/// para ver el perfil del profesional
Widget _name(BuildContext context, Profesional profesional, Cita cita) {
  final String text = profesional.nombre + " " + profesional.apellido;
  return Container(
    width: 359.0,
    child: Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
          alignment: Alignment.center,
          child: Icon(Icons.location_on),
        ),
        Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'CrearCita', arguments: cita);
              },
              child: Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(top: 15.0, right: 15.0),
                  child: Icon(Icons.edit, size: 40)),
            ),
            Container(
              width: 320.0,
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                bottom: 20.0,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'professionalDetails',
                      arguments: profesional);
                },
                child: AutoSizeText(
                  'Cita $text',
                  maxFontSize: 18.0,
                  minFontSize: 15.0,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xFF205072),
                    fontFamily: 'PoppinsRegular',
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.black,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                ),
              ),
            ),
          ],
        ),
        // Edit Button
      ],
    ),
  );
}

/// Sección Representante del estado de una cita
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

/// Selección del icono representativo del estado de la cita.
///
/// Aceptada: Simbolo Visto de color verde.
/// Rechazada: Simbolo de X de color rojo.
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

/// Creación de Botones de Adjuntar Pago y Cancelación de [Cita]
///
/// Cuando se quiere adjuntar el pago se redirige a [AttatchPayment()]
/// Cuando se cancela una cita se muestra un dialogo de confirmación y en caso de aceptar se envia la informacion a cancelar a  [cancelarCita()]
Widget _buttons(BuildContext context, Cita cita) {
  String text;
  if (cita.pago == "") {
    text = "ADJUNTAR PAGO";
  } else {
    text = "VER PAGO";
  }

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
              text,
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
              Navigator.pushNamed(context, 'AdjuntarPago', arguments: cita);
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
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return dialogoConfirmacion(
                        context,
                        "citasPaciente",
                        "Confirmación de Cancelación",
                        "¿Estás seguro que deseas cancelar esta Cita?",
                        cancelarCita,
                        parametro: cita);
                  });
            },
          ),
        ),
      ],
    ),
  );
}
