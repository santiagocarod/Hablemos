import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/model/grupo.dart';
import 'package:hablemos/ux/atoms.dart';
import 'dart:async';
import 'package:hablemos/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ModifyGroup extends StatefulWidget {
  @override
  _ModifyGroup createState() => _ModifyGroup();
}

class _ModifyGroup extends State<ModifyGroup> {
  String _date = '';
  String _time = '';
  TextEditingController _inputFieldDateController = new TextEditingController();
  TextEditingController _timeController = new TextEditingController();
  TextEditingController _ubicacionController = new TextEditingController();
  TextEditingController _descripcionController = new TextEditingController();
  TextEditingController _sesionesController = new TextEditingController();
  TextEditingController _precioController = new TextEditingController();
  TextEditingController _bancoController = new TextEditingController();
  TextEditingController _numCuentaController = new TextEditingController();
  TextEditingController _tituloController = new TextEditingController();

  File _image;
  final ImagePicker _imagePicker = new ImagePicker();

  _imagenDesdeCamara() async {
    PickedFile image = await _imagePicker.getImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = File(image.path);
    });
  }

  _imagenDesdeGaleria() async {
    PickedFile image = await _imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(image.path);
    });
  }

  Future<Null> _selectdate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2030));
    var myFormat = DateFormat('d/MM/yyyy');
    if (picked != null) {
      setState(() {
        _date = myFormat.format(picked).toString();
        _inputFieldDateController.text = _date;
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context, initialTime: new TimeOfDay.now());

    if (picked != null) {
      setState(() {
        _time = picked.toString().substring(10, 15);
        _timeController.text = _time;
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galeria de Fotos'),
                      trailing: new Icon(Icons.cloud_upload),
                      onTap: () {
                        _imagenDesdeGaleria();
                        //Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Cámara'),
                    trailing: new Icon(Icons.cloud_upload),
                    onTap: () {
                      _imagenDesdeCamara();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Grupo grupo = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: crearAppBarEventos(
          context, "Modificación de Grupo", "listarGruposAdmin"),
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/eventsAdminBackground.png',
            alignment: Alignment.center,
            fit: BoxFit.fill,
            width: size.width,
            height: size.height,
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.15,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  controller: _tituloController,
                  enableInteractiveSelection: false,
                  style: GoogleFonts.montserrat(
                      fontSize: 27.0, fontWeight: FontWeight.w300),
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: grupo.titulo),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: 365.0,
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: 315.0,
                          height: 137.0,
                          decoration: BoxDecoration(
                            image: grupo.foto,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 7.0,
                                  color: Colors.grey.withOpacity(0.5)),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40.0),
                            child: (_image != null)
                                ? new Image.file(_image)
                                : Container(),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _showPicker(context);
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 56.0,
                            width: 56.0,
                            decoration: BoxDecoration(
                              color: kBlanco,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 0),
                                    blurRadius: 7.0,
                                    color: Colors.grey.withOpacity(0.5)),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.camera_alt_rounded,
                                color: kNegro,
                                size: 28.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Column(
                  children: <Widget>[
                    Container(
                      width: 330.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Ubicación o Virtual",
                              style: TextStyle(
                                  fontFamily: "PoppinsRegular",
                                  fontSize: 18.0,
                                  color: kLetras.withOpacity(0.7)),
                            ),
                          ),
                          TextField(
                            controller: _ubicacionController
                              ..text = grupo.ubicacion,
                            enableInteractiveSelection: false,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: "PoppinsRegular",
                                fontSize: 15.0,
                                color: kLetras),
                            decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontFamily: "PoppinsRegular",
                                    fontSize: 15.0,
                                    color: kLetras),
                                contentPadding: EdgeInsets.only(bottom: 5.0)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 330.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Descripción",
                              style: TextStyle(
                                  fontFamily: "PoppinsRegular",
                                  fontSize: 18.0,
                                  color: kLetras.withOpacity(0.7)),
                            ),
                          ),
                          TextField(
                            controller: _descripcionController
                              ..text = grupo.descripcion,
                            enableInteractiveSelection: true,
                            keyboardType: TextInputType.multiline,
                            minLines: 3,
                            maxLines: 15,
                            style: TextStyle(
                                fontFamily: "PoppinsRegular",
                                fontSize: 15.0,
                                fontWeight: FontWeight.w300),
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintStyle: TextStyle(
                                    fontFamily: "PoppinsRegular",
                                    fontSize: 15.0,
                                    color: kLetras),
                                contentPadding:
                                    EdgeInsets.only(top: 5.0, bottom: 10.0)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 330.5,
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Horario",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontFamily: "PoppinsRegular",
                                  color: kLetras.withOpacity(0.7),
                                  fontSize: 18.0),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  _selectdate(context);
                                },
                                child: Container(
                                  child: Row(children: <Widget>[
                                    Icon(
                                      Icons.calendar_today_outlined,
                                      color: kNegro,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "$_date",
                                      style: TextStyle(
                                          fontFamily: "PoppinsRegular",
                                          color: kLetras,
                                          fontSize: 17.0),
                                    ),
                                  ]),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _selectTime(context);
                                },
                                child: Container(
                                  child: Row(children: <Widget>[
                                    Icon(
                                      Icons.access_time_outlined,
                                      color: kNegro,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "$_time",
                                      style: TextStyle(
                                          fontFamily: "PoppinsRegular",
                                          color: kLetras,
                                          fontSize: 17.0),
                                    ),
                                  ]),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 7.0,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Container(
                              height: 1.0,
                              color: kGrisN,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: 330.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 145.5,
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Sesiones",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: "PoppinsRegular",
                                        color: kLetras.withOpacity(0.7),
                                        fontSize: 18.0),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: TextField(
                                      controller: _sesionesController
                                        ..text =
                                            grupo.numeroSesiones.toString(),
                                      enableInteractiveSelection: false,
                                      style: TextStyle(
                                          fontFamily: "PoppinsRegular",
                                          color: kLetras,
                                          fontSize: 15.0),
                                      decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontFamily: "PoppinsRegular",
                                              fontSize: 15.0,
                                              color: kLetras),
                                          contentPadding: EdgeInsets.only(
                                              top: 5.0, bottom: 10.0))),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 145.5,
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Precio",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: "PoppinsRegular",
                                        color: kLetras.withOpacity(0.7),
                                        fontSize: 18.0),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: TextField(
                                      controller: _precioController
                                        ..text = grupo.valor,
                                      enableInteractiveSelection: false,
                                      style: TextStyle(
                                          fontFamily: "PoppinsRegular",
                                          color: kLetras,
                                          fontSize: 15.0),
                                      decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontFamily: "PoppinsRegular",
                                              fontSize: 15.0,
                                              color: kLetras),
                                          contentPadding: EdgeInsets.only(
                                              top: 5.0, bottom: 10.0))),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    _datosFinancieros(
                        context, grupo, _bancoController, _numCuentaController),
                    SizedBox(height: size.height * 0.04),
                    Container(
                      width: 330.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              /*Actividad nuevaActividad = new Actividad(
                                titulo: _tituloController.text,
                                valor: _precioController.text,
                                descripcion: _descripcionController.text,
                                ubicacion: _ubicacionController.text,
                                numeroSesiones:
                                    int.parse(_sesionesController.text),
                                banco: _bancoController.text,
                                numeroCuenta: _numCuentaController.text,
                              );
                              actividades.add(nuevaActividad);*/
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return dialogoConfirmacionMod(
                                      context,
                                      "verGrupoAdmin",
                                      "Confirmación de Modificación",
                                      "¿Está seguro que desea modificar este Grupo?",
                                      grupo);
                                },
                              );
                            },
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.check),
                                  SizedBox(width: 10.0),
                                  Text(
                                    "Guardar",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _datosFinancieros(
      BuildContext context,
      Grupo grupo,
      TextEditingController _bancoController,
      TextEditingController _numCuentaController) {
    if (grupo.ubicacion.toLowerCase() == "virtual") {
      return Container(
        width: 330.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 133.5,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Banco",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "PoppinsRegular",
                          color: kLetras.withOpacity(0.7),
                          fontSize: 18.0),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextField(
                        controller: _bancoController..text = grupo.banco,
                        enableInteractiveSelection: false,
                        style: TextStyle(
                            fontFamily: "PoppinsRegular",
                            color: kLetras,
                            fontSize: 15.0),
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontFamily: "PoppinsRegular",
                                fontSize: 15.0,
                                color: kLetras),
                            contentPadding:
                                EdgeInsets.only(top: 5.0, bottom: 10.0))),
                  ),
                ],
              ),
            ),
            Container(
              width: 183.5,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Número de Cuenta",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "PoppinsRegular",
                          color: kLetras.withOpacity(0.7),
                          fontSize: 18.0),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextField(
                        controller: _numCuentaController
                          ..text = grupo.numCuenta,
                        enableInteractiveSelection: false,
                        style: TextStyle(
                            fontFamily: "PoppinsRegular",
                            color: kLetras,
                            fontSize: 15.0),
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontFamily: "PoppinsRegular",
                                fontSize: 15.0,
                                color: kLetras),
                            contentPadding:
                                EdgeInsets.only(top: 5.0, bottom: 10.0))),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return SizedBox(height: 10.0);
    }
  }

  AlertDialog dialogoConfirmacionMod(BuildContext context, String rutaSi,
      String titulo, String mensaje, Grupo grupo) {
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
                      Navigator.pushNamed(context, rutaSi, arguments: grupo);
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
                    onTap: () {
                      Navigator.pop(context);
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
}
