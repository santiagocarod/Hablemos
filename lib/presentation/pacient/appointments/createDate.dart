import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/business/pacient/negocioCitas.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/util/snapshotConvertes.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/ux/loading_screen.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';

class CreateDate extends StatefulWidget {
  @override
  _CreateDate createState() => _CreateDate();
}

class _CreateDate extends State<CreateDate> {
  // Provisional list of professionals
  List<Profesional> professionals = [];
  // Provisional List of types
  List<String> types = ['Proceso', 'Cita Unica'];
  // Text Controllers
  TextEditingController _inputFieldDateController = new TextEditingController();
  TextEditingController _timeController = new TextEditingController();
  Profesional _profController;
  String _typeController;

  String textDate, textHour, textProf, textType;
  String _date = '', _hour = '';

  @override
  Widget build(BuildContext context) {
    final Cita cita = ModalRoute.of(context).settings.arguments;
    DateFormat format = DateFormat('hh:mm');

    // Validates if it is update or creation
    if (cita != null) {
      textDate = cita.dateTime.day.toString() +
          '/' +
          cita.dateTime.month.toString() +
          '/' +
          cita.dateTime.year.toString();
      textHour = format.format(cita.dateTime);
      textProf = cita.profesional.nombreCompleto();
      textType = cita.tipo;
    } else if (cita == null) {
      textDate = "Fecha";
      textHour = "Hora";
      textProf = "Profesional";
      textType = "Tipo de Cita";
    }
    Size size = MediaQuery.of(context).size;

    CollectionReference citasCollection =
        FirebaseFirestore.instance.collection("professionals");
    return StreamBuilder<QuerySnapshot>(
        stream: citasCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('ALGO SALIO MAL');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingScreen();
          }
          professionals = profesionalMapToList(snapshot);

          // Screen
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
                  appBar: crearAppBar("Crear Cita", null, 0, null,
                      context: context),
                  body: Stack(
                    children: <Widget>[
                      // Information
                      Padding(
                        padding: const EdgeInsets.only(top: 100.0),
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                _informationSection(
                                    "La cita tiene un costo de: \$$COSTO_CITA"),
                                _dateInfo(context, size),
                                _professionalInfo(context, size, professionals),
                                _dateType(context, size),
                                SizedBox(height: 40),
                                _informationSection(
                                    "Recuerde que no somos un servicio de Urgencias.\nSi necesita atención inmediata dirigase a la sección de\n''Necesito Ayuda''"),
                                SizedBox(height: 20),
                                _informationSection(
                                    "Por esto tu cita tiene que ser con minimo:\n3 dias de Anticipación"),
                                _create(context, cita),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget _informationSection(String text) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
          child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'PoppinsRegular', fontSize: 15, color: kLetras),
      )),
    );
  }

// Date and Time text Fields
  Widget _dateInfo(BuildContext context, Size size) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Date Text Field
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
          // Time Text Field
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

// Picker Date
  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1945),
      lastDate: new DateTime(2025),
    );
    var myFormat = DateFormat('d/MM/yyyy');
    if (picked != null) {
      setState(() {
        _date = myFormat.format(picked).toString();
        _inputFieldDateController.text = _date;
      });
    }
  }

// Picker Time
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

// Professional Text Field and Button
  Widget _professionalInfo(
      BuildContext context, Size size, List<Profesional> professionals) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: <Widget>[
              // Icon
              SizedBox(
                width: 48,
                height: 48,
                child: Icon(
                  Icons.list,
                  color: Colors.black,
                  size: 48,
                ),
              ),
              // Scroll List
              SizedBox(
                width: size.width - 88,
                height: 42,
                child: DropdownButton(
                  isExpanded: true,
                  hint: Center(
                      child: Text(
                    textProf,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontFamily: 'PoppinRegular',
                    ),
                  )),
                  value: _profController,
                  items: professionals.map((prof) {
                    return DropdownMenuItem<Profesional>(
                      child: Center(child: Text(prof.nombreCompleto())),
                      value: prof,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _profController = value;
                    });
                  },
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontFamily: 'PoppinRegular',
                  ),
                ),
              ),
            ],
          ),
          // Space
          SizedBox(height: 15.0),
          // Button Professionals
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
                Navigator.pushNamed(context, 'detalleProfesional',
                    arguments: professionals);
              },
            ),
          ),
        ],
      ),
    );
  }

// Type Text Field
  Widget _dateType(BuildContext context, Size size) {
    return Container(
      padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
      child: Row(
        children: <Widget>[
          // Icon
          SizedBox(
            width: 48,
            height: 48,
            child: Icon(
              Icons.list,
              color: Colors.black,
              size: 48,
            ),
          ),
          // Scroll List
          SizedBox(
            width: size.width - 88,
            height: 42,
            child: DropdownButton(
              isExpanded: true,
              hint: Center(
                  child: Text(
                textType,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontFamily: 'PoppinRegular',
                ),
              )),
              value: _typeController,
              items: types.map((type) {
                return DropdownMenuItem<String>(
                  child: Center(child: Text(type)),
                  value: type,
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _typeController = value;
                });
              },
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontFamily: 'PoppinRegular',
              ),
            ),
          ),
        ],
      ),
    );
  }

// Crea el botón encargado de crear una cita.
  Widget _create(BuildContext context, Cita cita) {
    String button = "CREAR";
    // Cambiar el texto del boton, si es una modificacion de cita
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
            String title = "";
            String content = "";

            // Validate si es la creación de una cita
            if (cita == null) {
              // Validar la existencia de campos no vacios
              if (_inputFieldDateController.text.isNotEmpty &&
                  _timeController.text.isNotEmpty &&
                  _profController != null &&
                  _typeController.isNotEmpty) {
                DateTime date = DateFormat('d/M/yyyy hh:mm').parse(
                    _inputFieldDateController.text +
                        ' ' +
                        _timeController.text);

                cita = new Cita(
                  profesional: _profController,
                  dateTime: date,
                  tipo: _typeController,
                );

                agregarCita(cita).then((value) {
                  if (value) {
                    title = 'Cita Creada';
                    content =
                        "Tu cita fue creada exitosamente, espera a la aprobación del profesional.";
                  } else {
                    title = 'Error en la creación';
                    content =
                        "Por favor verifica los campos.\nRecuerda que la cita tiene que ser para dentro de más de 3 días.";
                  }
                  showDialog(
                    context: context,
                    builder: (BuildContext contex) =>
                        _buildPopupDialog(context, title, content),
                  );
                });

                // Si los campos obligatorios de una cita estan vacios
              } else {
                title = 'No se pudo crear la cita';
                content =
                    "Ha habido un error, asegurate de llenar todos los campos.";
                showDialog(
                  context: context,
                  builder: (BuildContext contex) =>
                      _buildPopupDialog(context, title, content),
                );
              }
              // Validate si es la modificación o actualización de una cita.
            } else {
              // Asignar valores de los controladores con los valores existentes, si estos no han cambiado.
              if (_inputFieldDateController.text.isEmpty)
                _inputFieldDateController.text = textDate;
              if (_timeController.text.isEmpty) _timeController.text = textHour;
              if (_profController == null) _profController = cita.profesional;
              if (_typeController == null) _typeController = textType;
              DateTime date = DateFormat('d/M/yyyy hh:mm').parse(
                  _inputFieldDateController.text + ' ' + _timeController.text);

              if (actualizarCitaPaciente(
                  cita, _profController, date, _typeController)) {
                title = 'Cita Actualizada';
                content =
                    "Tu cita fue actualizada exitosamente, espere a la aprobación del profesional";
              } else {
                title = 'Error';
                content =
                    "No puede actualizar tu cita con menos de 3 dias de anticipación.";
              }
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

// Construcción de Dialogo de confirmación de cita.
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
            Navigator.pushNamed(context, "citasPaciente");
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
