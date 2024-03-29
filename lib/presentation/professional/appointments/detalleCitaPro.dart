import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/business/pacient/negocioCitas.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/presentation/professional/appointments/editarCita.dart';
import 'package:hablemos/presentation/professional/appointments/pacientDetails.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:intl/intl.dart';

/// Clase encargada de mostrar la informacion de una [Cita] al profesional
///
/// Recibe una [Cita] como parámetro y muestra su información completa.
class DetalleCitaPro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Cita cita = ModalRoute.of(context).settings.arguments;

    final DateFormat houformat = DateFormat('hh:mm a');
    final String hour = houformat.format(cita.dateTime);
    final String date = cita.dateTime.day.toString() +
        '/' +
        cita.dateTime.month.toString() +
        '/' +
        cita.dateTime.year.toString();
    final price = NumberFormat('#,###');
    final String priceDate = '\$' + price.format(cita.costo);
    final String paymentDetails = cita.profesional.banco.toString();
    final String place = cita.lugar;
    final String specialty = cita.especialidad;
    final String type = cita.tipo;
    final String contact = cita.profesional.celular.toString();

    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          child: Image.asset(
            'assets/images/dateBack.png',
            alignment: Alignment.center,
            fit: BoxFit.fill,
            width: size.width,
            height: size.height,
          ),
        ),
        SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    width: size.width * 0.9,
                    padding: EdgeInsets.only(
                      top: size.height * 0.025,
                      bottom: 30.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _pageHeader(context, size, "Detalle Cita Profesional"),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              //margin: EdgeInsets.all(20),
                              width: 359.0,
                              height: 630.0,
                              decoration: BoxDecoration(
                                color: kBlanco,
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 0),
                                      blurRadius: 5.0,
                                      color: Colors.grey.withOpacity(0.5)),
                                ],
                              ),
                              child: Column(
                                children: <Widget>[
                                  _headerDate(context, cita),
                                  secction(title: 'Hora:', text: hour),
                                  SizedBox(height: 3.0),
                                  secction(title: 'Fecha:', text: date),
                                  SizedBox(height: 3.0),
                                  secction(title: 'Costo:', text: priceDate),
                                  SizedBox(height: 3.0),
                                  secction(
                                      title: 'Detalles de Pago:',
                                      text: paymentDetails,
                                      banco: true),
                                  SizedBox(height: 3.0),
                                  secction(title: 'Lugar:', text: place),
                                  SizedBox(height: 3.0),
                                  secction(
                                      title: 'Especialidad:', text: specialty),
                                  SizedBox(height: 3.0),
                                  secction(title: 'Tipo:', text: type),
                                  SizedBox(height: 3.0),
                                  secction(title: 'Contacto:', text: contact),
                                  SizedBox(height: 3.0),
                                  _dateState(context, cita),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  _buttons(context, cita),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
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
}

/// Widget que determina el icono según [Cita.estado]
///
/// En caso de estar aprobado pone un icono verde
/// En caso contrario pone un icono rojo
Widget _dateState(BuildContext context, Cita cita) {
  final bool state = cita.estado;
  return Container(
    padding: EdgeInsets.only(top: 10.0),
    width: 270.0,
    height: 46,
    child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Text(
          'Estado:',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14.0,
            color: kLetras,
            fontFamily: 'PoppinsRegular',
            decoration: TextDecoration.none,
          ),
        ),
        _stateIcon(state),
      ],
    ),
  );
}

/// Método encargado de desplegar el icono de [_dateState()]
Widget _stateIcon(bool state) {
  if (state == false) {
    return Container(
      padding: EdgeInsets.only(top: 5.0),
      child: Icon(
        Icons.cancel,
        size: 61,
        color: kRojo,
      ),
    );
  } else {
    return Container(
      padding: EdgeInsets.only(top: 5.0),
      child: Icon(
        Icons.check_circle,
        size: 61,
        color: kVerde,
      ),
    );
  }
}

/// Método encargado de mostrar la cabera de la cita
///
/// En la cabecera se va a poner el nombre del paciente con el cual se tiene la cita.
/// Además se tiene el botón que redirige a [EditCitaPro()] para editar la cita.
/// En el nombre del [Paciente] tiene un hipervinculo a su Perfil
Widget _headerDate(BuildContext context, Cita cita) {
  String pacientName = cita.paciente.nombreCompleto();
  return Container(
    width: 359.0,
    child: Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
          alignment: Alignment.center,
          child: Icon(Icons.location_on),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditCitaPro(cita: cita)));
          },
          child: Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(top: 10.0, right: 15.0, bottom: 5.0),
              child: Icon(Icons.edit, size: 37)),
        ),
        Container(
          width: 359.0,
          alignment: Alignment.center,
          margin: EdgeInsets.only(
            top: 50.0,
            bottom: 15.0,
            right: 15.0,
            left: 15.0,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      PacientDetails(paciente: cita.paciente)));
            },
            child: AutoSizeText(
              "Cita con $pacientName",
              maxFontSize: 18.0,
              minFontSize: 15.0,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'PoppinsRegular',
                fontStyle: FontStyle.normal,
                fontSize: 18,
                color: kAzulOscuro,
                decoration: TextDecoration.underline,
                decorationColor: kNegro,
                decorationStyle: TextDecorationStyle.solid,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

/// Método encargado de mostrar los botones de acciones con la [Cita]
///
/// Va a mostrar los botones de ver el pago y cancelar la cita.
/// El botón de ver el pago solo se va a poder ver cuando la [Cita.pago] sea diferente a vacio `""` o `null`
@override
Widget _buttons(BuildContext context, Cita cita) {
  if (cita.pago == "" || cita.pago == null) {
    return Container(
      width: 359.0,
      padding: EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return dialogoConfirmacion(
                        context,
                        'citasProfesional',
                        "Confirmación de Cancelación",
                        "¿Estás seguro que deseas cancelar esta Cita?",
                        cancelarCita,
                        parametro: cita);
                  });
            },
            child: Container(
                alignment: Alignment.center,
                width: 126,
                height: 35,
                decoration: BoxDecoration(
                  color: kRojoOscuro,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 5,
                        color: Colors.grey.withOpacity(0.5)),
                  ],
                ),
                child: Text(
                  'CANCELAR',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 9.5,
                      color: kNegro,
                      letterSpacing: 4,
                      decoration: TextDecoration.none),
                )),
          ),
        ],
      ),
    );
  } else {
    return Container(
      width: 359.0,
      padding: EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'VerPagoPro', arguments: cita);
            },
            child: Container(
                alignment: Alignment.center,
                width: 126,
                height: 35,
                decoration: BoxDecoration(
                  color: kBlanco,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 5,
                        color: Colors.grey.withOpacity(0.5)),
                  ],
                ),
                child: Text(
                  'VER PAGO',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 9.5,
                      color: kNegro,
                      letterSpacing: 4,
                      decoration: TextDecoration.none),
                )),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return dialogoConfirmacion(
                        context,
                        'citasProfesional',
                        "Confirmación de Cancelación",
                        "¿Estás seguro que deseas cancelar esta Cita?",
                        cancelarCita,
                        parametro: cita);
                  });
            },
            child: Container(
                alignment: Alignment.center,
                width: 126,
                height: 35,
                decoration: BoxDecoration(
                  color: kRojoOscuro,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 5,
                        color: Colors.grey.withOpacity(0.5)),
                  ],
                ),
                child: Text(
                  'CANCELAR',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 9.5,
                      color: kNegro,
                      letterSpacing: 4,
                      decoration: TextDecoration.none),
                )),
          ),
        ],
      ),
    );
  }
}

/// Mostrar la cebecera de la pantalla total
Widget _pageHeader(BuildContext context, Size size, String titulo) {
  return Container(
    padding: EdgeInsets.only(bottom: size.height * 0.03),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'citasProfesional');
          },
          child: Container(
              padding: EdgeInsets.only(left: size.width * 0.05),
              child: Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: kNegro,
              )),
        ),
        Container(
          child: Container(
            child: Text(
              titulo,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 22, color: kNegro, decoration: TextDecoration.none),
            ),
          ),
        ),
        SizedBox(width: size.width * 0.05),
      ],
    ),
  );
}
