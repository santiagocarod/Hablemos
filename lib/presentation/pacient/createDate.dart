import 'package:flutter/material.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:intl/intl.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:hablemos/services/providers/profesionales_provider.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/cita.dart';

class CreateDate extends StatefulWidget {
  @override
  _CreateDate createState() => _CreateDate();
}

class _CreateDate extends State<CreateDate> {
  String profesional = ProfesionalesProvider.getProfesional().nombre +
      " " +
      ProfesionalesProvider.getProfesional().apellido;
  var professionals = List<String>.filled(
      5,
      ProfesionalesProvider.getProfesional().nombre +
          " " +
          ProfesionalesProvider.getProfesional().apellido);

  var types = List<String>.filled(5, "Tipo");
  TextEditingController _inputFieldDateController = new TextEditingController();
  TextEditingController _timeController = new TextEditingController();
  TextEditingController _profController = new TextEditingController();
  TextEditingController _typeController = new TextEditingController();

  String textDate, textHour, textProf, textType;
  String _date = '', _hour = '';

  @override
  Widget build(BuildContext context) {
    final Cita cita = ModalRoute.of(context).settings.arguments;
    DateFormat format = DateFormat('hh:mm a');

    if (cita != null) {
      textDate = cita.dateTime.day.toString() +
          '-' +
          cita.dateTime.month.toString() +
          '-' +
          cita.dateTime.year.toString();
      textHour = format.format(cita.dateTime);
      textProf = cita.uidProfesional;
      textType = cita.tipo;
    } else {
      textDate = "Fecha";
      textHour = "Hora";
      textProf = "Profesional";
      textType = "Tipo de Cita";
    }
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBar("Crear Cita", null, 0, null),
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
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _dateInfo(context, size),
                    _professionalInfo(context, size),
                    _dateType(context, size),
                    _create(context, cita),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateInfo(BuildContext context, Size size) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: (size.width / 2) - 48,
            height: 65,
            child: TextField(
              controller: _inputFieldDateController,
              enableInteractiveSelection: false,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.date_range,
                  color: Colors.black,
                  size: 48,
                ),
                hintText: textDate,
                hintStyle: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontFamily: 'PoppinRegular',
                ),
              ),
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                _selectDate(context);
              },
            ),
          ),
          Container(
            width: (size.width / 2) - 48,
            height: 65,
            child: TextField(
              controller: _timeController,
              enableInteractiveSelection: false,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.access_time,
                  color: Colors.black,
                  size: 48,
                ),
                hintText: textHour,
                hintStyle: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontFamily: 'PoppinRegular',
                ),
              ),
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                _selectTime(context);
              },
            ),
          ),
        ],
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
    var myFormat = DateFormat('d-MM-yyyy');
    if (picked != null) {
      setState(() {
        _date = myFormat.format(picked).toString();
        _inputFieldDateController.text = _date;
      });
    }
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: new TimeOfDay.now(),
    );
    if (picked != null)
      setState(() {
        _hour = picked.toString().substring(10, 15);
        _timeController.text = _hour;
      });
  }

  Widget _professionalInfo(BuildContext context, Size size) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: _profController,
            enableInteractiveSelection: false,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.list,
                color: Colors.black,
                size: 48,
              ),
              contentPadding: EdgeInsets.only(right: 48.0, top: 20.0),
              hintText: textProf,
              hintStyle: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontFamily: 'PoppinRegular',
              ),
            ),
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              _selectProfessional(context);
            },
          ),
          SizedBox(height: 20.0),
          SizedBox(
            width: 176,
            height: 46,
            child: ElevatedButton(
              child: Text(
                "VER PROFESIONALES",
                style: TextStyle(
                  fontSize: 12.0,
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
                Navigator.pushNamed(context, 'detalleProfesional');
              },
            ),
          ),
        ],
      ),
    );
  }

  _selectProfessional(BuildContext context) {
    return showMaterialScrollPicker(
      context: context,
      title: "Profesionales",
      items: professionals,
      selectedItem: profesional,
      showDivider: false,
      onChanged: (value) => setState(() {
        _profController.text = value.toString();
      }),
    );
  }

  Widget _dateType(BuildContext context, Size size) {
    return Container(
      padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
      child: TextField(
        controller: _typeController,
        enableInteractiveSelection: false,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(right: 48.0, top: 20.0),
          prefixIcon: Icon(
            Icons.list,
            color: Colors.black,
            size: 48,
          ),
          hintText: textType,
          hintStyle: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
            fontFamily: 'PoppinRegular',
          ),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectType(context);
        },
      ),
    );
  }

  _selectType(BuildContext context) {
    return showMaterialScrollPicker(
      context: context,
      title: "Tipos de Cita",
      items: types,
      selectedItem: types[0],
      showDivider: false,
      onChanged: (value) => setState(() {
        _typeController.text = value.toString();
      }),
    );
  }

  Widget _create(BuildContext context, Cita cita) {
    String username = "Paciente";
    String title = "";
    String content = "";
    String button = "CREAR";
    if (cita != null) button = "ACTUALIZAR";
    return Container(
      padding:
          EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
      child: SizedBox(
        width: 155,
        height: 43,
        child: ElevatedButton(
          child: Text(
            button,
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.black,
              letterSpacing: 2,
              fontFamily: 'PoppinSemiBold',
            ),
            textAlign: TextAlign.center,
          ),
          style: ElevatedButton.styleFrom(
            primary: kRojoOscuro,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(378.0),
            ),
            shadowColor: Colors.black,
          ),
          onPressed: () {
            if (_inputFieldDateController.text.isNotEmpty &&
                _timeController.text.isNotEmpty &&
                _profController.text.isNotEmpty &&
                _typeController.text.isNotEmpty) {
              DateTime date = DateFormat('d-M-yyyy hh:mm').parse(
                  _inputFieldDateController.text + ' ' + _timeController.text);
              if (cita == null) {
                cita = new Cita(
                  uidPaciente: username,
                  uidProfesional: _profController.text,
                  dateTime: date,
                  tipo: _typeController.text,
                );
                title = 'Cita Creada';
                content =
                    "Su cita fue creada exitosamente, espere a la aprobación del profesional";
                showDialog(
                  context: context,
                  builder: (BuildContext contex) =>
                      _buildPopupDialog(context, title, content),
                );
              } else {
                cita.uidProfesional = _profController.text;
                cita.dateTime = date;
                title = 'Cita Actualizada';
                content =
                    "Su cita fue actualizada exitosamente, espere a la aprobación del profesional";
                showDialog(
                  context: context,
                  builder: (BuildContext contex) =>
                      _buildPopupDialog(context, title, content),
                );
              }
            } else {
              title = 'No se pudo crear la cita';
              content =
                  "Ha habido un error, asegurese de llenar todos los campos";
              showDialog(
                context: context,
                builder: (BuildContext contex) =>
                    _buildPopupDialog(context, title, content),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildPopupDialog(
      BuildContext context, String tittle, String content) {
    return new AlertDialog(
      title: Text(tittle),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(content),
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            primary: kRojoOscuro,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(378.0),
            ),
            shadowColor: Colors.black,
          ),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}
