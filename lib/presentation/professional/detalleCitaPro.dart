import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:intl/intl.dart';

class DetalleCitaPro extends StatelessWidget {
  final Profesional profesional;

  DetalleCitaPro({Key key, @required this.profesional}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Cita> citas = profesional.citas;
    Cita cita = citas[0];
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/dateBack.png',
            alignment: Alignment.center,
            fit: BoxFit.cover,
            width: size.width,
            height: size.height,
          ),
          Container(
            height: size.height,
            padding: EdgeInsets.only(
              top: size.height * 0.06,
            ),
            child: Column(
              children: <Widget>[
                _pageHeader(context, size),
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: size.height * 0.04),
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
                          _dateHour(context, cita),
                          _dateDate(context, cita),
                          _datePrice(context, cita),
                          _datePayment(context, profesional),
                          _datePlace(context, cita),
                          _dateSpecialty(context, cita),
                          _dateType(context, cita),
                          _dateContact(context, profesional),
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

Widget _dateHour(BuildContext context, Cita cita) {
  final DateFormat format = DateFormat('hh:mm a');
  final String hour = format.format(cita.dateTime);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 40.0),
    child: Stack(
      children: <Widget>[
        Container(
          child: Text(
            'Hora:',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 14.0,
                color: kLetras,
                fontFamily: 'PoppinsRegular',
                decoration: TextDecoration.none),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 14),
              child: Text(
                '$hour',
                style: TextStyle(
                    fontSize: 14.0,
                    color: kLetras,
                    fontFamily: 'PoppinsRegular',
                    decoration: TextDecoration.none),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 4,
              child: Divider(
                color: Colors.black.withOpacity(0.40),
                thickness: 3.0,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _dateDate(BuildContext context, Cita cita) {
  final DateFormat format = DateFormat('dd/mm/yyyy');
  final String date = format.format(cita.dateTime);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 40.0),
    child: Stack(
      children: <Widget>[
        Container(
          child: Text(
            'Fecha:',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 14.0,
                color: kLetras,
                fontFamily: 'PoppinsRegular',
                decoration: TextDecoration.none),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 14),
              child: Text(
                '$date',
                style: TextStyle(
                    fontSize: 14.0,
                    color: kLetras,
                    fontFamily: 'PoppinsRegular',
                    decoration: TextDecoration.none),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 4,
              child: Divider(
                color: Colors.black.withOpacity(0.40),
                thickness: 3.0,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _datePrice(BuildContext context, Cita cita) {
  final format = NumberFormat('#,###');
  final String price = format.format(cita.costo);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 40.0),
    child: Stack(
      children: <Widget>[
        Container(
          child: Text(
            'Costo:',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 14.0,
                color: kLetras,
                fontFamily: 'PoppinsRegular',
                decoration: TextDecoration.none),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 14),
              child: Text(
                '$price',
                style: TextStyle(
                    fontSize: 14.0,
                    color: kLetras,
                    fontFamily: 'PoppinsRegular',
                    decoration: TextDecoration.none),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 4,
              child: Divider(
                color: Colors.black.withOpacity(0.40),
                thickness: 3.0,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _datePayment(BuildContext context, Profesional profesional) {
  int accountNumber = profesional.numeroCuenta;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 40.0),
    child: Stack(
      children: <Widget>[
        Container(
          child: Text(
            'Detalles de Pago:',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 14.0,
                color: kLetras,
                fontFamily: 'PoppinsRegular',
                decoration: TextDecoration.none),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 19),
              child: Text(
                '$accountNumber',
                style: TextStyle(
                    fontSize: 14.0,
                    color: kLetras,
                    fontFamily: 'PoppinsRegular',
                    decoration: TextDecoration.none),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 4,
              child: Divider(
                color: Colors.black.withOpacity(0.40),
                thickness: 3.0,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _datePlace(BuildContext context, Cita cita) {
  String place = cita.lugar;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 40.0),
    child: Stack(
      children: <Widget>[
        Container(
          child: Text(
            'Lugar:',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 14.0,
                color: kLetras,
                fontFamily: 'PoppinsRegular',
                decoration: TextDecoration.none),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 19),
              child: Text(
                '$place',
                style: TextStyle(
                    fontSize: 14.0,
                    color: kLetras,
                    fontFamily: 'PoppinsRegular',
                    decoration: TextDecoration.none),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 4,
              child: Divider(
                color: Colors.black.withOpacity(0.40),
                thickness: 3.0,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _dateSpecialty(BuildContext context, Cita cita) {
  String specialty = cita.especialidad;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 40.0),
    child: Stack(
      children: <Widget>[
        Container(
          child: Text(
            'Especialidad:',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 14.0,
                color: kLetras,
                fontFamily: 'PoppinsRegular',
                decoration: TextDecoration.none),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 19),
              child: Text(
                '$specialty',
                style: TextStyle(
                    fontSize: 14.0,
                    color: kLetras,
                    fontFamily: 'PoppinsRegular',
                    decoration: TextDecoration.none),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 4,
              child: Divider(
                color: Colors.black.withOpacity(0.40),
                thickness: 3.0,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _dateType(BuildContext context, Cita cita) {
  String type = cita.tipo;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 40.0),
    child: Stack(
      children: <Widget>[
        Container(
          child: Text(
            'Tipo:',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 14.0,
                color: kLetras,
                fontFamily: 'PoppinsRegular',
                decoration: TextDecoration.none),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 19),
              child: Text(
                '$type',
                style: TextStyle(
                    fontSize: 14.0,
                    color: kLetras,
                    fontFamily: 'PoppinsRegular',
                    decoration: TextDecoration.none),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 4,
              child: Divider(
                color: Colors.black.withOpacity(0.40),
                thickness: 3.0,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _dateContact(BuildContext context, Profesional profesional) {
  int contactNumber = profesional.celular;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 40.0),
    child: Stack(
      children: <Widget>[
        Container(
          child: Text(
            'Contacto:',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 14.0,
                color: kLetras,
                fontFamily: 'PoppinsRegular',
                decoration: TextDecoration.none),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 19),
              child: Text(
                '$contactNumber',
                style: TextStyle(
                    fontSize: 14.0,
                    color: kLetras,
                    fontFamily: 'PoppinsRegular',
                    decoration: TextDecoration.none),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 4,
              child: Divider(
                color: Colors.black.withOpacity(0.40),
                thickness: 3.0,
              ),
            ),
          ],
        ),
      ],
    ),
  );
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
      padding: EdgeInsets.only(top: 20.0),
      child: Icon(
        Icons.cancel,
        size: 61,
        color: kRojo,
      ),
    );
  } else {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
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
      padding: EdgeInsets.only(top: 70),
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
      padding: EdgeInsets.only(top: 70),
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
