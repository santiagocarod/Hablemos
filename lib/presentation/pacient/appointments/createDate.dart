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

/// Clase encargada de la creación y modificacion de las [Cita] para el paciente.
///
/// Puede escoger un dia, con un horario disponible y un profesional especifico.
/// Tambien pueden escoger el tipo de la cita.
class CreateDate extends StatefulWidget {
  @override
  _CreateDate createState() => _CreateDate();
}

/// Esta misma clase se usa para la modifiación por lo que recibe una [Cita] por argumento de la ruta.
///
/// En caso de ser `null` es una creacion y en caso diferente es una moficación
class _CreateDate extends State<CreateDate> {
  // Provisional list of professionals
  List<Profesional> professionals = [];

  /// Lista provisional de los tipos de citas
  List<String> types = TIPOS_DE_CITA;

  TextEditingController _inputFieldDateController = new TextEditingController();
  TextEditingController _timeController = new TextEditingController();
  Profesional _profController;
  String _typeController;

  String textDate, textHour, textProf, textType;
  String _date = '', _hour = '';
  List<dynamic> horarios = [];

  @override
  Widget build(BuildContext context) {
    final Cita cita = ModalRoute.of(context).settings.arguments;
    DateFormat format = DateFormat('hh:mm');

    if (cita != null) {
      textDate = cita.dateTime.day.toString() +
          '/' +
          cita.dateTime.month.toString() +
          '/' +
          cita.dateTime.year.toString();
      textHour = format.format(cita.dateTime);
      textProf = cita.profesional.nombreCompleto();
      textType = cita.tipo;
      if (_hour == '') {
        _updateHours(
            cita.profesional.uid,
            cita.dateTime.day.toString() +
                "/" +
                cita.dateTime.month.toString() +
                "/" +
                cita.dateTime.year.toString(),
            cita);
      }
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
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  resizeToAvoidBottomInset: false,
                  extendBodyBehindAppBar: true,
                  appBar: crearAppBar("Crear Cita", null, 0, null,
                      context: context),
                  body: Stack(
                    children: <Widget>[
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
                                _dateInfo(context, size, cita),
                                _professionalInfo(
                                    context, size, professionals, cita),
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

  /// Seccion de información general
  ///
  /// Esta seccion se usa de manera general para crear avisos e información general útil
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

  /// Sección que permite escoger la fecha y la hora
  ///
  /// La hora es una lista de horas disponibles (Eliminando las que ya estan tomadas)
  Widget _dateInfo(BuildContext context, Size size, Cita cita) {
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
                _selectDate(context, cita);
              },
            ),
          ),
          // Time Text Field
          Container(
              width: (size.width / 2) - 48,
              height: 65,
              child: DropdownButton(
                  icon: Icon(Icons.access_time),
                  iconDisabledColor: kGris,
                  iconEnabledColor: Colors.black,
                  iconSize: 32,
                  isExpanded: true,
                  value: _hour,
                  items: horarios.map((hora) {
                    return DropdownMenuItem<String>(
                      child: Center(child: Text(hora)),
                      value: hora,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _hour = value;
                    });
                  },
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontFamily: 'PoppinRegular',
                  ))),
        ],
      ),
    );
  }

  /// Crea un picker para la fecha en especifico
  _selectDate(BuildContext context, Cita cita) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1945),
      lastDate: new DateTime(2025),
    );
    var myFormat = DateFormat('d/MM/yyyy');
    if (picked != null) {
      _date = myFormat.format(picked).toString();
      if (_profController != null) {
        _updateHours(_profController.uid, _date, cita);
      }
      setState(() {
        _inputFieldDateController.text = _date;
      });
    }
  }

  /// Crea una lista desplegable con una lista de [Profesional]
  ///
  /// Además tiene un botón que redirije a [ListProfessional()] en donde se muestra una lista de todos los profesionales
  /// de la organización con su respectivo perfil.
  Widget _professionalInfo(BuildContext context, Size size,
      List<Profesional> professionals, Cita cita) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: <Widget>[
              SizedBox(
                width: 48,
                height: 48,
                child: Icon(
                  Icons.list,
                  color: Colors.black,
                  size: 48,
                ),
              ),
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
                    if (cita != null) {
                      _updateHours(value.uid, textDate, cita);
                    } else {
                      if (_inputFieldDateController.text != "") {
                        _updateHours(
                            value.uid, _inputFieldDateController.text, cita);
                      }
                    }
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
          SizedBox(height: 15.0),
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

  /// Cuando se hace la actualización de el profesional escogido para la cita o la fecha escogida es necesario actualizar la lista de horas disponibles
  ///
  /// Esto se hace consultando las citas que ya estan tomadas en las horas especificas
  /// A la lista de horas posibles le quita las horas ya tomadas y esta es la lista desplegable.
  void _updateHours(String profUid, String date, Cita cita) {
    List<String> horas = [];
    for (int i = HORA_INICIO_CONSULTAS; i <= HORA_FIN_CONSULTAS; i++) {
      horas.add("$i:00");
    }

    DateTime dia = DateFormat('d/M/yyyy hh:mm').parse(date + ' 00:00');
    DateTime despues = DateTime(dia.year, dia.month, dia.day + 1);
    FirebaseFirestore.instance
        .collection("appoinments")
        .where("professional.uid", isEqualTo: profUid)
        .where("dateTime", isGreaterThanOrEqualTo: dia)
        .where("dateTime", isLessThan: despues)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        Timestamp timestamp = element.data()["dateTime"];
        DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(
            timestamp.microsecondsSinceEpoch);
        dateTime = DateTime(
            dateTime.year, dateTime.month, dateTime.day, dateTime.hour);

        String horaUsada = dateTime.hour.toString() + ":00";

        horas.remove(horaUsada);
      });
      String horaApartada = "";
      if (cita != null) {
        horaApartada = cita.dateTime.hour.toString() +
            ":" +
            (cita.dateTime.minute.toString().length == 1
                ? "0" + cita.dateTime.minute.toString()
                : cita.dateTime.minute.toString());
      }
      if (_hour == "" && cita != null) {
        _hour = horaApartada;
      } else {
        _hour = horas.length > 0 ? horas[0] : null;
      }
      setState(() {
        if (cita != null &&
            profUid == cita.profesional.uid &&
            (cita.dateTime.day == dia.day &&
                cita.dateTime.month == dia.month &&
                cita.dateTime.year == dia.year)) {
          horas.add(horaApartada);
          horas.sort((a, b) =>
              int.parse(a.split(":")[0]).compareTo(int.parse(b.split(":")[0])));
        }
        horarios = horas;
      });
    });
  }

  /// Lista desplegable del tipo de citas
  ///
  /// Los valores vienen de [TIPOS_DE_CITA]
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

  /// Botón encargado del evento final al momento de crear o actualizar una [Cita].
  ///
  /// Toma los valores consignados en los campos anteriores y crea una [Cita]
  /// Si es una creacion envia los datos a [agregarCita()]
  /// Si es una Modificación envia los datos a [actualizarCitaPaciente()]
  ///
  /// Si ocurrió algún error muestra un dialogo
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
                  _hour != "" &&
                  _profController != null &&
                  _typeController.isNotEmpty) {
                DateTime date = DateFormat('d/M/yyyy hh:mm')
                    .parse(_inputFieldDateController.text + ' ' + _hour);

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
              DateTime date = DateFormat('d/M/yyyy hh:mm')
                  .parse(_inputFieldDateController.text + ' ' + _hour);

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

  /// Construcción de Dialogo de confirmación de cita.
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
