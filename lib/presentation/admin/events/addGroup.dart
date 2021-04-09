import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/model/grupo.dart';

import 'package:hablemos/services/providers/eventos_provider.dart';
import 'package:hablemos/ux/atoms.dart';
import 'dart:async';
import 'package:hablemos/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddGroup extends StatefulWidget {
  @override
  _AddGroup createState() => _AddGroup();
}

class _AddGroup extends State<AddGroup> {
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
  final List<Grupo> grupos = EventoProvider.getGrupos();

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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar:
          crearAppBarEventos(context, "Creación de Grupo", "listarGruposAdmin"),
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
                  controller: _tituloController,
                  enableInteractiveSelection: false,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontSize: 27.0, fontWeight: FontWeight.w300),
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Nombre Grupo'),
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
                            controller: _ubicacionController,
                            enableInteractiveSelection: false,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: "PoppinsRegular",
                                fontSize: 15.0,
                                fontWeight: FontWeight.w300),
                            decoration: InputDecoration(
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
                            controller: _descripcionController,
                            enableInteractiveSelection: false,
                            keyboardType: TextInputType.multiline,
                            minLines: 3,
                            maxLines: 15,
                            style: TextStyle(
                                fontFamily: "PoppinsRegular",
                                fontSize: 15.0,
                                fontWeight: FontWeight.w300),
                            decoration: InputDecoration(
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
                                    controller: _sesionesController,
                                    enableInteractiveSelection: false,
                                    style: TextStyle(
                                        fontFamily: "PoppinsRegular",
                                        color: kLetras,
                                        fontSize: 15.0),
                                  ),
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
                                    controller: _precioController,
                                    enableInteractiveSelection: false,
                                    style: TextStyle(
                                        fontFamily: "PoppinsRegular",
                                        color: kLetras,
                                        fontSize: 15.0),
                                  ),
                                ),
                              ],
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
                                    controller: _bancoController,
                                    enableInteractiveSelection: false,
                                    style: TextStyle(
                                        fontFamily: "PoppinsRegular",
                                        color: kLetras,
                                        fontSize: 15.0),
                                  ),
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
                                    controller: _numCuentaController,
                                    enableInteractiveSelection: false,
                                    style: TextStyle(
                                        fontFamily: "PoppinsRegular",
                                        color: kLetras,
                                        fontSize: 15.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 330.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Foto",
                              style: TextStyle(
                                  fontFamily: "PoppinsRegular",
                                  fontSize: 18.0,
                                  color: kLetras.withOpacity(0.7)),
                            ),
                          ),
                          Container(
                            width: 238.0,
                            height: 181.0,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40.0),
                                    border: Border(
                                      top: BorderSide(
                                        color: kLetras.withOpacity(0.7),
                                      ),
                                      bottom: BorderSide(
                                        color: kLetras.withOpacity(0.7),
                                      ),
                                      left: BorderSide(
                                        color: kLetras.withOpacity(0.7),
                                      ),
                                      right: BorderSide(
                                        color: kLetras.withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40.0),
                                    child: (_image != null)
                                        ? new Image.file(_image)
                                        : Container(),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _showPicker(context);
                                  },
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10.0),
                                      height: 56.0,
                                      width: 56.0,
                                      decoration: BoxDecoration(
                                        color: kBlanco,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 0),
                                              blurRadius: 7.0,
                                              color:
                                                  Colors.grey.withOpacity(0.5)),
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
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    Container(
                      width: 330.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              /*Grupo nuevaGrupo = new Grupo(
                                titulo: _tituloController.text,
                                valor: _precioController.text,
                                descripcion: _descripcionController.text,
                                ubicacion: _ubicacionController.text,
                                numeroSesiones:
                                    int.parse(_sesionesController.text),
                                banco: _bancoController.text,
                                numeroCuenta: _numCuentaController.text,
                              );
                              grupos.add(nuevaGrupo);*/
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return dialogoConfirmacion(
                                      context,
                                      "listarGruposAdmin",
                                      "Confirmación de Creación",
                                      "¿Está seguro que desea crear un nuevo Grupo?");
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
}
