import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:intl/intl.dart';

class EditCitaPro extends StatelessWidget {
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
    final String paymentDetails = cita.profesional.banco.numCuenta;
    final String place = cita.lugar;
    final String specialty = cita.especialidad;
    final String type = cita.especialidad;
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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: size.height * 0.017,
                  ),
                  child: Column(
                    children: <Widget>[
                      _pageHeader(context, size, "Editar Cita"),
                      Material(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              width: 359.0,
                              height: 599.0,
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
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  secctionEdit('Hora:', hour, cita),
                                  SizedBox(height: 2),
                                  secctionEdit('Fecha:', date, cita),
                                  SizedBox(height: 2),
                                  secctionEdit('Costo', priceDate, cita),
                                  SizedBox(height: 2),
                                  secctionEdit('Detalles de Pago:',
                                      paymentDetails, cita),
                                  SizedBox(height: 2),
                                  secctionEdit('Lugar:', place, cita),
                                  SizedBox(height: 2),
                                  secctionEdit(
                                      'Especialidad:', specialty, cita),
                                  SizedBox(height: 2),
                                  secctionEdit('Tipo:', type, cita),
                                  SizedBox(height: 2),
                                  secctionEdit('Contacto:', contact, cita),
                                  SizedBox(height: 2),
                                  _dateState(context, cita),
                                  _buttons(context, cita),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget _dateState(BuildContext context, Cita cita) {
  final bool state = cita.estado;
  return Container(
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
            fontFamily: 'PoppinSemiBold',
            decoration: TextDecoration.none,
          ),
        ),
        _stateIcon(state),
      ],
    ),
  );
}

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

Widget secctionEdit(String title, String text, Cita cita) {
  return Container(
    margin: EdgeInsets.only(bottom: 2.0),
    width: 270.0,
    height: 46,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 270.0,
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              fontFamily: 'PoppinSemiBold',
              decoration: TextDecoration.none,
            ),
          ),
        ),
        SizedBox(
          height: 7.0,
        ),
        Container(
          width: 270.0,
          height: 14.0,
          child: TextField(
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14.0, color: kLetras, fontFamily: 'PoppinsRegular'),
            textAlignVertical: TextAlignVertical.center,
            controller: TextEditingController()..text = text,
            maxLines: 1,
            enableInteractiveSelection: true,
            autofocus: false,
          ),
        ),
      ],
    ),
  ); //Boton como los de ejercicios queiro respirar, mindfulness, quiero meditar
}

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
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(
            top: 40.0,
          ),
          child: Text(
            "Cita con $pacientName",
            style: GoogleFonts.roboto(
                fontStyle: FontStyle.normal,
                fontSize: 16,
                color: kNegro,
                decoration: TextDecoration.none),
          ),
        ),
      ],
    ),
  );
}

@override
Widget _buttons(BuildContext context, Cita cita) {
  final bool state = cita.estado;
  if (state == false) {
    return Container(
      width: 359.0,
      padding: EdgeInsets.only(top: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
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
      padding: EdgeInsets.only(top: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'VerPagoPro');
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
                        "¿Estás seguro que deseas cancelar esta Cita?");
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
                color: kLetras,
              )),
        ),
        Center(
          child: Container(
            child: Text(
              titulo,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 22,
                  color: kNegro,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        SizedBox(width: size.width * 0.05),
      ],
    ),
  );
}
