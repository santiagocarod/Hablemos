import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:intl/intl.dart';
import 'package:hablemos/ux/atoms.dart';

class DetalleCitaPro extends StatelessWidget {
  final Profesional profesional;

  DetalleCitaPro({Key key, @required this.profesional}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Cita> citas = profesional.citas;
    Cita cita = citas[0];

    final DateFormat houformat = DateFormat('hh:mm a');
    final String hour = houformat.format(cita.dateTime);
    final String date = cita.dateTime.day.toString() +
        '/' +
        cita.dateTime.month.toString() +
        '/' +
        cita.dateTime.year.toString();
    final price = NumberFormat('#,###');
    final String priceDate = '\$' + price.format(cita.costo);
    final String paymentDetails = profesional.numeroCuenta.toString();
    final String place = cita.lugar;
    final String specialty = cita.especialidad;
    final String type = cita.especialidad;
    final String contact = profesional.celular.toString();

    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/dateBack.png',
            alignment: Alignment.center,
            fit: BoxFit.fill,
            width: size.width,
            height: size.height,
          ),
          Container(
            padding: EdgeInsets.only(
              top: size.height * 0.06,
            ),
            child: Column(
              children: <Widget>[
                _pageHeader(context, size),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      //margin: EdgeInsets.all(20),
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
                          secction(title: 'Hora:', text: hour),
                          secction(title: 'Fecha:', text: date),
                          secction(title: 'Costo', text: priceDate),
                          secction(
                              title: 'Detalles de pago:', text: paymentDetails),
                          secction(title: 'Lugar:', text: place),
                          secction(title: 'Especialidad:', text: specialty),
                          secction(title: 'Tipo:', text: type),
                          secction(title: 'Contacto:', text: contact),
                          _dateState(context, cita),
                          _buttons(context, cita),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

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

Widget _headerDate(BuildContext context, Cita cita) {
  String pacientName = cita.uidPaciente;
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
      padding: EdgeInsets.only(top: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: () {},
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
      padding: EdgeInsets.only(top: 50),
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
            onTap: () {},
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

Widget _pageHeader(BuildContext context, Size size) {
  return Container(
    padding: EdgeInsets.only(bottom: size.height * 0.03),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'inicio');
          },
          child: Container(
              padding: EdgeInsets.only(left: size.width * 0.05),
              child: Icon(
                Icons.arrow_back,
                size: 30,
                color: kNegro,
              )),
        ),
        Container(
          child: Container(
            child: Text(
              'Detalle de Cita',
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
