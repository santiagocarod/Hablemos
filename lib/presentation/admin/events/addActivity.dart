import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/business/admin/negocioEventos.dart';
import 'package:hablemos/business/cloudinary.dart';
import 'package:hablemos/model/actividad.dart';
import 'package:hablemos/model/banco.dart';
import 'package:hablemos/ux/atoms.dart';
import 'dart:async';
import 'package:hablemos/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddActivity extends StatefulWidget {
  @override
  _AddActivity createState() => _AddActivity();
}

class _AddActivity extends State<AddActivity> {
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

  _imagenDesdeCamara() async {
    PickedFile image = await _imagePicker.getImage(
        source: ImageSource.camera, imageQuality: 50);

    uploadImage(image.path, ACTIVITY_FOLDER).then((value) {
      if (value != null) {
        _image = value;
        Navigator.pop(context);
        setState(() {});
      } else {
        showAlertDialog(
            context, "Hubo un error subiendo la foto, inténtelo nuevamente");
      }
    });
  }

  _imagenDesdeGaleria() async {
    PickedFile image = await _imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);

    uploadImage(image.path, ACTIVITY_FOLDER).then((value) {
      if (value != null) {
        _image = value;
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
                        if (_image != null) {
                          deleteImage(_image);
                        }
                        _imagenDesdeGaleria();
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

    return Container(
      color: kAmarilloClaro,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: crearAppBarEventos(
              context, "Creación de Actividad", "listarActividadesAdmin"),
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
                      height: size.height * 0.1,
                    ),
                    TextField(
                      controller: _tituloController,
                      enableInteractiveSelection: false,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontSize: 27.0, fontWeight: FontWeight.w300),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nombre Actividad'),
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
                                enableInteractiveSelection: false,
                                keyboardType: TextInputType.multiline,
                                minLines: 3,
                                maxLines: 15,
                                style: TextStyle(
                                    fontFamily: "PoppinsRegular",
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w300),
                                decoration: InputDecoration(
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
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          if (value != "" && value != "0") {
                                            setState(() {
                                              bancoTextField = TextField(
                                                enabled: true,
                                                controller: _bancoController,
                                                enableInteractiveSelection:
                                                    false,
                                                style: TextStyle(
                                                    fontFamily:
                                                        "PoppinsRegular",
                                                    color: kLetras,
                                                    fontSize: 15.0),
                                              );
                                              tipoCuentaTextField = TextField(
                                                enabled: true,
                                                controller: _bancoController,
                                                enableInteractiveSelection:
                                                    false,
                                                style: TextStyle(
                                                    fontFamily:
                                                        "PoppinsRegular",
                                                    color: kLetras,
                                                    fontSize: 15.0),
                                              );
                                              numeroCuentaTextField = TextField(
                                                enabled: true,
                                                controller: _bancoController,
                                                enableInteractiveSelection:
                                                    false,
                                                style: TextStyle(
                                                    fontFamily:
                                                        "PoppinsRegular",
                                                    color: kLetras,
                                                    fontSize: 15.0),
                                              );
                                            });
                                          } else if (bancoTextField.enabled) {
                                            setState(() {
                                              bancoTextField = TextField(
                                                enabled: false,
                                                controller: _bancoController,
                                                enableInteractiveSelection:
                                                    false,
                                                style: TextStyle(
                                                    fontFamily:
                                                        "PoppinsRegular",
                                                    color: kLetras,
                                                    fontSize: 15.0),
                                              );
                                              tipoCuentaTextField = TextField(
                                                enabled: false,
                                                controller: _bancoController,
                                                enableInteractiveSelection:
                                                    false,
                                                style: TextStyle(
                                                    fontFamily:
                                                        "PoppinsRegular",
                                                    color: kLetras,
                                                    fontSize: 15.0),
                                              );
                                              numeroCuentaTextField = TextField(
                                                enabled: false,
                                                controller: _bancoController,
                                                enableInteractiveSelection:
                                                    false,
                                                style: TextStyle(
                                                    fontFamily:
                                                        "PoppinsRegular",
                                                    color: kLetras,
                                                    fontSize: 15.0),
                                              );
                                            });
                                          }
                                        },
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
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            child: bancoTextField),
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
                                        borderRadius:
                                            BorderRadius.circular(40.0),
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
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        child: (_image != null)
                                            ? new Image.network(
                                                _image,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent
                                                            loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
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
                                                  color: Colors.grey
                                                      .withOpacity(0.5)),
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
                                  if (bancoTextField.enabled) {
                                    if (_tituloController.text == "" ||
                                        _ubicacionController.text == "" ||
                                        _bancoController.text == "" ||
                                        _date == null ||
                                        _descripcionController.text == "" ||
                                        _sesionesController.text == "" ||
                                        _numCuentaController.text == "" ||
                                        _tipoCuentaController.text == "" ||
                                        _time == null ||
                                        _image == null) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext contex) =>
                                              _buildPopupDialog(
                                                  context,
                                                  "Error",
                                                  "Por favor ingresa todos los valores"));
                                    } else {
                                      Actividad actividad = Actividad(
                                        banco: Banco(
                                          banco: _bancoController.text,
                                          numCuenta: _numCuentaController.text,
                                          tipoCuenta:
                                              _tipoCuentaController.text,
                                        ),
                                        descripcion:
                                            _descripcionController.text,
                                        fecha: _date.toString(),
                                        hora: _time.toString(),
                                        numeroSesiones:
                                            int.parse(_sesionesController.text),
                                        titulo: _tituloController.text,
                                        ubicacion: _ubicacionController.text,
                                        valor: _precioController.text,
                                        foto: _image,
                                      );
                                      if (agregarActividades(actividad)) {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext contex) =>
                                                _buildPopupDialog(
                                                    context,
                                                    "Exito!",
                                                    "Actividad Agregada!",
                                                    ruta:
                                                        "listarActividadesAdmin"));
                                      }
                                    }
                                  } else {
                                    if (_tituloController.text == "" ||
                                        _ubicacionController.text == "" ||
                                        _date == null ||
                                        _descripcionController.text == "" ||
                                        _time == null ||
                                        _image == null) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext contex) =>
                                              _buildPopupDialog(
                                                  context,
                                                  "Error",
                                                  "Por favor ingresa todos los valores"));
                                    } else {
                                      Actividad actividad = Actividad(
                                        descripcion:
                                            _descripcionController.text,
                                        fecha: _date.toString(),
                                        hora: _time.toString(),
                                        numeroSesiones:
                                            int.parse(_sesionesController.text),
                                        titulo: _tituloController.text,
                                        ubicacion: _ubicacionController.text,
                                        valor: _precioController.text,
                                        foto: _image,
                                      );

                                      if (agregarActividades(actividad)) {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext contex) =>
                                                _buildPopupDialog(
                                                    context,
                                                    "Exito!",
                                                    "Actividad Agregada!",
                                                    ruta:
                                                        "listarActividadesAdmin"));
                                      }
                                    }
                                  }
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
