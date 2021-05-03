import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/business/pacient/negocioCitas.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/cita.dart';
import 'package:intl/intl.dart';

class EditCitaPro extends StatefulWidget {
  final Cita cita;
  const EditCitaPro({this.cita});
  @override
  _EditCitaProState createState() => _EditCitaProState();
}

class _EditCitaProState extends State<EditCitaPro> {
  DateFormat hourformat = DateFormat('hh:mm a');
  TextEditingController hour;
  TextEditingController date;
  TextEditingController paymentDetails;
  TextEditingController place;
  TextEditingController priceDate;
  TextEditingController specialty;
  TextEditingController type;
  TextEditingController contact;
  @override
  void initState() {
    super.initState();

    DateFormat hourformat = DateFormat('hh:mm a');
    hour = TextEditingController()
      ..text = hourformat.format(widget.cita.dateTime);
    date = TextEditingController()
      ..text = widget.cita.dateTime.day.toString() +
          '/' +
          widget.cita.dateTime.month.toString() +
          '/' +
          widget.cita.dateTime.year.toString();
    paymentDetails = TextEditingController()
      ..text = widget.cita.profesional.banco.numCuenta;
    place = TextEditingController()..text = widget.cita.lugar;
    priceDate = TextEditingController()..text = widget.cita.costo.toString();
    specialty = TextEditingController()..text = widget.cita.especialidad;
    type = TextEditingController()..text = widget.cita.tipo;
    contact = TextEditingController()
      ..text = widget.cita.profesional.celular.toString();
  }

  @override
  Widget build(BuildContext context) {
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
                      _pageHeader(context, size, "Editar Cita", widget.cita),
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
                                  _headerDate(context, widget.cita),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  secctionEdit('Hora:', hour),
                                  SizedBox(height: 2),
                                  secctionEdit('Fecha:', date),
                                  SizedBox(height: 2),
                                  secctionEdit('Costo', priceDate),
                                  SizedBox(height: 2),
                                  secctionEdit(
                                      'Detalles de Pago:', paymentDetails),
                                  SizedBox(height: 2),
                                  secctionEdit('Lugar:', place),
                                  SizedBox(height: 2),
                                  secctionEdit('Especialidad:', specialty),
                                  SizedBox(height: 2),
                                  secctionEdit('Tipo:', type),
                                  SizedBox(height: 2),
                                  secctionEdit('Contacto:', contact),
                                  SizedBox(height: 2),
                                  _dateState(context, widget.cita),
                                  _buttons(context, widget.cita, {
                                    "precio": priceDate,
                                    "hora": hour,
                                    "fecha": date,
                                    "detalles": paymentDetails,
                                    "lugar": place,
                                    "especialidad": specialty,
                                    "tipo": type,
                                    "contacto": contact
                                  }),
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

Widget secctionEdit(String title, TextEditingController textEditingController) {
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
            controller: textEditingController,
            onChanged: (text) {
              textEditingController.text = text;
              textEditingController.selection = TextSelection.fromPosition(
                  TextPosition(offset: textEditingController.text.length));
            },
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
Widget _buttons(BuildContext context, Cita cita, Map map) {
  return Container(
    width: 126.0,
    padding: EdgeInsets.only(top: 30.0),
    child: GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return dialogoConfirmacionG(
                  context,
                  'citasProfesional',
                  "Confirmación de Modificación",
                  "¿Estás seguro que deseas modificar esta Cita?",
                  cita,
                  map);
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
          'GUARDAR',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              fontSize: 9.5,
              color: kNegro,
              letterSpacing: 4,
              decoration: TextDecoration.none),
        ),
      ),
    ),
  );
}

Widget _pageHeader(BuildContext context, Size size, String titulo, Cita cita) {
  return Container(
    padding: EdgeInsets.only(bottom: size.height * 0.03),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'detalleCitasProfesional',
                arguments: cita);
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

AlertDialog dialogoConfirmacionG(BuildContext context, String rutaSi,
    String titulo, String mensaje, Cita cita, Map map) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
        side: BorderSide(color: kNegro, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(37.0))),
    backgroundColor: kBlanco,
    content: Container(
      height: 170.0,
      width: 302.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "$titulo",
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold, fontSize: 16, color: kNegro),
          ),
          SizedBox(
            height: 25.0,
          ),
          Container(
            width: 259.0,
            height: 55.0,
            child: Text(
              "$mensaje",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  color: kNegro, fontSize: 15, fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    actualizarCitaProfesional(cita, map);
                    Navigator.pushNamed(context, rutaSi, arguments: cita);
                  },
                  child: Container(
                    height: 30,
                    width: 99,
                    decoration: BoxDecoration(
                      border: Border.all(color: kNegro),
                      borderRadius: BorderRadius.all(
                        Radius.circular(22.0),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Si",
                          style: GoogleFonts.montserrat(
                              color: kNegro,
                              fontSize: 14,
                              fontWeight: FontWeight.w300)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 30,
                    width: 99,
                    decoration: BoxDecoration(
                      border: Border.all(color: kNegro),
                      borderRadius: BorderRadius.all(
                        Radius.circular(22.0),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("No",
                          style: GoogleFonts.montserrat(
                              color: kNegro,
                              fontSize: 14,
                              fontWeight: FontWeight.w300)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
