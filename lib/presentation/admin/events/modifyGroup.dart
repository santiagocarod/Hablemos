import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/business/admin/negocioEventos.dart';
import 'package:hablemos/business/cloudinary.dart';
import 'package:hablemos/model/banco.dart';
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
  TextEditingController _tipoCuentaController = new TextEditingController();
  TextEditingController _tituloController = new TextEditingController();
  TextField bancoTextField;
  TextField tipoCuentaTextField;
  TextField numeroCuentaTextField;

  void initState() {
    super.initState();
    bancoTextField = TextField(
      enabled: false,
      controller: _bancoController,
      enableInteractiveSelection: false,
      style: TextStyle(
          fontFamily: "PoppinsRegular", color: kLetras, fontSize: 15.0),
    );
    tipoCuentaTextField = TextField(
      enabled: false,
      controller: _bancoController,
      enableInteractiveSelection: false,
      style: TextStyle(
          fontFamily: "PoppinsRegular", color: kLetras, fontSize: 15.0),
    );
    numeroCuentaTextField = TextField(
      enabled: false,
      controller: _bancoController,
      enableInteractiveSelection: false,
      style: TextStyle(
          fontFamily: "PoppinsRegular", color: kLetras, fontSize: 15.0),
    );
  }

  String _image;
  final ImagePicker _imagePicker = new ImagePicker();

  _imagenDesdeCamara(Grupo grupo) async {
    PickedFile image = await _imagePicker.getImage(
        source: ImageSource.camera, imageQuality: 50);

    uploadImage(image.path, GROUP_FOLDER).then((value) {
      if (value != null) {
        _image = value;
        grupo.foto = value;
        Navigator.pop(context);
        setState(() {});
      } else {
        showAlertDialog(
            context, "Hubo un error subiendo la foto, inténtelo nuevamente");
      }
    });
  }

  _imagenDesdeGaleria(Grupo grupo) async {
    PickedFile image = await _imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);

    uploadImage(image.path, GROUP_FOLDER).then((value) {
      if (value != null) {
        _image = value;
        grupo.foto = value;
        Navigator.pop(context);
        setState(() {
          build(context);
        });
      } else {
        showAlertDialog(
            context, "Hubo un error subiendo la foto, inténtelo nuevamente");
      }
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

  void _showPicker(context, grupo) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return SafeArea(
            bottom: false,
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galeria de Fotos'),
                      trailing: new Icon(Icons.cloud_upload),
                      onTap: () {
                        if (_image != null) {
                          deleteImage(_image);
                        }
                        _imagenDesdeGaleria(grupo);
                        //Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Cámara'),
                    trailing: new Icon(Icons.cloud_upload),
                    onTap: () {
                      if (_image != null) {
                        deleteImage(_image);
                      }
                      _imagenDesdeCamara(grupo);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    _inputFieldDateController.dispose();
    _timeController.dispose();
    _ubicacionController.dispose();
    _bancoController.dispose();
    _descripcionController.dispose();
    _tituloController.dispose();
    _tituloController.dispose();
    _tipoCuentaController.dispose();
    _numCuentaController.dispose();
    _precioController.dispose();
    _sesionesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Grupo grupo = ModalRoute.of(context).settings.arguments;

    if (grupo.banco == null) {
      _ubicacionController = TextEditingController()..text = grupo.ubicacion;
      _ubicacionController.selection = TextSelection.fromPosition(
          TextPosition(offset: _ubicacionController.text.length));
      _descripcionController = TextEditingController()
        ..text = grupo.descripcion;
      _descripcionController.selection = TextSelection.fromPosition(
          TextPosition(offset: _descripcionController.text.length));
      _tituloController = TextEditingController()..text = grupo.titulo;
      _tituloController.selection = TextSelection.fromPosition(
          TextPosition(offset: _tituloController.text.length));
      _date = grupo.fecha;
      _time = grupo.hora;
      _precioController = TextEditingController()..text = grupo.valor;
      _precioController.selection = TextSelection.fromPosition(
          TextPosition(offset: _precioController.text.length));
      _sesionesController = TextEditingController()
        ..text = grupo.numeroSesiones.toString();
      _sesionesController.selection = TextSelection.fromPosition(
          TextPosition(offset: _sesionesController.text.length));
    } else {
      _ubicacionController = TextEditingController()..text = grupo.ubicacion;
      _ubicacionController.selection = TextSelection.fromPosition(
          TextPosition(offset: _ubicacionController.text.length));
      _bancoController = TextEditingController()..text = grupo.banco.banco;
      _bancoController.selection = TextSelection.fromPosition(
          TextPosition(offset: _bancoController.text.length));
      _descripcionController = TextEditingController()
        ..text = grupo.descripcion;
      _descripcionController.selection = TextSelection.fromPosition(
          TextPosition(offset: _descripcionController.text.length));
      _tituloController = TextEditingController()..text = grupo.titulo;
      _tituloController.selection = TextSelection.fromPosition(
          TextPosition(offset: _tituloController.text.length));
      _date = grupo.fecha;
      _time = grupo.hora;
      _numCuentaController = TextEditingController()
        ..text = grupo.banco.numCuenta.toString();
      _numCuentaController.selection = TextSelection.fromPosition(
          TextPosition(offset: _numCuentaController.text.length));
      _tipoCuentaController = TextEditingController()
        ..text = grupo.banco.tipoCuenta.toString();
      _tipoCuentaController.selection = TextSelection.fromPosition(
          TextPosition(offset: _tipoCuentaController.text.length));
      _precioController = TextEditingController()..text = grupo.valor;
      _precioController.selection = TextSelection.fromPosition(
          TextPosition(offset: _precioController.text.length));
      _sesionesController = TextEditingController()
        ..text = grupo.numeroSesiones.toString();
      _sesionesController.selection = TextSelection.fromPosition(
          TextPosition(offset: _sesionesController.text.length));
      _image = grupo.foto;
    }

    bancoTextField = TextField(
        controller: _bancoController,
        enabled: grupo.banco == null ? false : true,
        onChanged: (text) {
          if (text.isNotEmpty) {
            grupo.banco.banco = text;
          }
        },
        enableInteractiveSelection: false,
        style: TextStyle(
            fontFamily: "PoppinsRegular", color: kLetras, fontSize: 15.0),
        decoration: InputDecoration(
            hintStyle: TextStyle(
                fontFamily: "PoppinsRegular", fontSize: 15.0, color: kLetras),
            contentPadding: EdgeInsets.only(top: 5.0, bottom: 10.0)));
    tipoCuentaTextField = TextField(
        enabled: grupo.banco == null ? false : true,
        controller: _tipoCuentaController,
        onChanged: (text) {
          if (text.isNotEmpty) {
            grupo.banco.tipoCuenta = text;
          }
        },
        enableInteractiveSelection: false,
        style: TextStyle(
            fontFamily: "PoppinsRegular", color: kLetras, fontSize: 15.0),
        decoration: InputDecoration(
            hintStyle: TextStyle(
                fontFamily: "PoppinsRegular", fontSize: 15.0, color: kLetras),
            contentPadding: EdgeInsets.only(top: 5.0, bottom: 10.0)));
    numeroCuentaTextField = TextField(
        enabled: grupo.banco == null ? false : true,
        controller: _numCuentaController,
        onChanged: (text) {
          if (text.isNotEmpty) {
            grupo.banco.numCuenta = text;
          }
        },
        enableInteractiveSelection: false,
        style: TextStyle(
            fontFamily: "PoppinsRegular", color: kLetras, fontSize: 15.0),
        decoration: InputDecoration(
            hintStyle: TextStyle(
                fontFamily: "PoppinsRegular", fontSize: 15.0, color: kLetras),
            contentPadding: EdgeInsets.only(top: 5.0, bottom: 10.0)));

    return Container(
      color: kAmarilloClaro,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
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
                      onChanged: (text) {
                        if (text.isNotEmpty) {
                          grupo.titulo = text;
                        }
                      },
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
                                image: DecorationImage(
                                    image: NetworkImage(grupo.foto)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
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
                                    ? new Image.network(
                                        _image,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes
                                                  : null,
                                            ),
                                          );
                                        },
                                      )
                                    : Container(),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _showPicker(context, grupo);
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
                                controller: _ubicacionController,
                                onChanged: (text) {
                                  if (text.isNotEmpty) {
                                    grupo.ubicacion = text;
                                  }
                                },
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
                                    contentPadding:
                                        EdgeInsets.only(bottom: 5.0)),
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
                                onChanged: (text) {
                                  if (text.isNotEmpty) {
                                    grupo.descripcion = text;
                                  }
                                },
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
                                    contentPadding: EdgeInsets.only(
                                        top: 5.0, bottom: 10.0)),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          onChanged: (text) {
                                            if (text.isNotEmpty) {
                                              grupo.numeroSesiones =
                                                  int.parse(text);
                                            }
                                          },
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
                                          controller: _precioController,
                                          keyboardType: TextInputType.number,
                                          onChanged: (text) {
                                            if (text.isNotEmpty) {
                                              grupo.valor = text;
                                              setState(() {
                                                if (text != "" && text != "0") {
                                                  grupo.banco = Banco(
                                                      banco: "",
                                                      numCuenta: "",
                                                      tipoCuenta: "");
                                                } else {
                                                  grupo.banco = null;
                                                }
                                              });
                                            }
                                          },
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
                        _datosFinancieros(context, grupo, _bancoController,
                            _numCuentaController, _tipoCuentaController),
                        SizedBox(height: size.height * 0.04),
                        Container(
                          width: 330.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return dialogoConfirmacionMod(
                                          context,
                                          "verGrupoAdmin",
                                          "Confirmación de Modificación",
                                          "¿Está seguro que desea modificar este grupo?",
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
        ),
      ),
    );
  }

  Widget _datosFinancieros(
      BuildContext context,
      Grupo grupo,
      TextEditingController _bancoController,
      TextEditingController _numCuentaController,
      TextEditingController _tipoCuentaController) {
    return Container(
      width: 330.5,
      child: Column(
        children: [
          Row(
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
                      child: bancoTextField,
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
                        "Tipo de Cuenta",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontFamily: "PoppinsRegular",
                            color: kLetras.withOpacity(0.7),
                            fontSize: 18.0),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: tipoCuentaTextField,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: 330.5,
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
                  child: numeroCuentaTextField,
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
                      if (bancoTextField.enabled) {
                        if (_tituloController.text == "" ||
                            _ubicacionController.text == "" ||
                            _bancoController.text == "" ||
                            _date == null ||
                            _descripcionController.text == "" ||
                            _sesionesController.text == "" ||
                            _numCuentaController.text == "" ||
                            _time == null) {
                          showDialog(
                              context: context,
                              builder: (BuildContext contex) =>
                                  _buildPopupDialog(context, "Error",
                                      "Por favor ingresa todos los valores"));
                        } else {
                          if (actualizarGrupo(grupo)) {
                            showDialog(
                                context: context,
                                builder: (BuildContext contex) =>
                                    _buildPopupDialog(
                                        context, "Exito!", "Grupo editado!",
                                        ruta: "listarGruposAdmin"));
                          }
                        }
                      } else {
                        if (_tituloController.text == "" ||
                            _ubicacionController.text == "" ||
                            _date == null ||
                            _descripcionController.text == "" ||
                            _time == null) {
                          showDialog(
                              context: context,
                              builder: (BuildContext contex) =>
                                  _buildPopupDialog(context, "Error",
                                      "Por favor ingresa todos los valores"));
                        } else {
                          if (actualizarGrupo(grupo)) {
                            grupo.banco = null;
                            showDialog(
                                context: context,
                                builder: (BuildContext contex) =>
                                    _buildPopupDialog(
                                        context, "Exito!", "Grupo editado!",
                                        ruta: "listarGruposAdmin"));
                          }
                        }
                      }

                      // Navigator.pushNamed(context, rutaSi, arguments: grupo);
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

Widget _buildPopupDialog(BuildContext context, String tittle, String content,
    {String ruta}) {
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
          if (ruta != null) {
            Navigator.pushNamed(context, ruta);
          }
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
