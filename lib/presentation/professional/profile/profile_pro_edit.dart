import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/business/admin/negocioPagos.dart';
import 'package:hablemos/business/cloudinary.dart';
import 'package:hablemos/business/professional/negocioProfesional.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/util/snapshotConvertes.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/ux/loading_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants.dart';

///Clase encargada de organizar la informacion de [Profesional] para ser editada
///
///Hay un boton de guardar que hara la peticion a firebase y guardara la entidad [Profesional]
///Hay un boton de eliminar el cual elimina en firebase la entidad [Profesional]

class EditProfileProfesional extends StatefulWidget {
  final Profesional profesional;
  const EditProfileProfesional({this.profesional});
  @override
  _EditProfileProfesionalState createState() => _EditProfileProfesionalState();
}

class _EditProfileProfesionalState extends State<EditProfileProfesional> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _mailController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _cityController = new TextEditingController();
  TextEditingController _convenioController = new TextEditingController();
  TextEditingController _especialidadController = new TextEditingController();
  TextEditingController _proyectosController = new TextEditingController();
  TextEditingController _experienciaController = new TextEditingController();
  TextEditingController _descripcionController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _bankNameController = new TextEditingController();
  TextEditingController _accountNumberController = new TextEditingController();
  TextEditingController _accountTypeController = new TextEditingController();

  String _image;
  final ImagePicker _imagePicker = new ImagePicker();

  @override
  void initState() {
    super.initState();

    _mailController = TextEditingController()..text = widget.profesional.correo;
    _cityController = TextEditingController()..text = widget.profesional.ciudad;
    _phoneController = TextEditingController()
      ..text = widget.profesional.celular;
    _nameController = TextEditingController()..text = widget.profesional.nombre;
    _lastNameController = TextEditingController()
      ..text = widget.profesional.apellido;
    _convenioController = TextEditingController()
      ..text = widget.profesional.convenios.toString();
    _proyectosController = TextEditingController()
      ..text = widget.profesional.proyectos.toString();
    _especialidadController = TextEditingController()
      ..text = widget.profesional.especialidad;
    _experienciaController = TextEditingController()
      ..text = widget.profesional.experiencia;
    _descripcionController = TextEditingController()
      ..text = widget.profesional.descripcion;
    _bankNameController = TextEditingController()
      ..text = widget.profesional.banco.banco;
    _accountNumberController = TextEditingController()
      ..text = widget.profesional.banco.numCuenta;
    _accountTypeController = TextEditingController()
      ..text = widget.profesional.banco.tipoCuenta;
    _image = widget.profesional.foto;
  }

  /// Pone la imagen desde camara
  _imagenDesdeCamara(Profesional profesional) async {
    PickedFile image = await _imagePicker.getImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      uploadImage(image.path, PROFILE_FOLDER).then((value) {
        if (value != null) {
          actualizarPerfilPro(profesional, value).then((val) {
            if (profesional.foto != null) {
              deleteImage(profesional.foto);
            }
            if (val) {
              _image = value;
              Navigator.pop(context);
              setState(() {});
            } else {
              showAlertDialog(context,
                  "Hubo un error subiendo la foto, inténtalo nuevamente.");
            }
          });
        }
      });
    });
  }

  /// Pone la imagen desde galeria
  _imagenDesdeGaleria(Profesional profesional) async {
    PickedFile image = await _imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);

    uploadImage(image.path, PROFILE_FOLDER).then((value) {
      if (value != null) {
        actualizarPerfilPro(profesional, value).then((val) {
          if (profesional.foto != null) {
            deleteImage(profesional.foto);
          }
          if (val) {
            _image = value;
            Navigator.pop(context);
            setState(() {
              build(context);
            });
          } else {
            showAlertDialog(context,
                "Hubo un error subiendo la foto, inténtalo nuevamente.");
          }
        });
      }
    });
  }

  /// Despliega las opciones de imagenes (Camara o galeria)
  void _showPicker(context, profesional) {
    deleteImage(profesional.foto);
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
                        _imagenDesdeGaleria(profesional);
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Cámara'),
                    trailing: new Icon(Icons.cloud_upload),
                    onTap: () {
                      _imagenDesdeCamara(profesional);
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
      color: kRosado,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          // Create an empty appBar, display the arrow back
          appBar: crearAppBar('', null, 0, null, context: context),
          body: Stack(
            children: <Widget>[
              cabeceraPerfilProfesional(size, _nameController,
                  _lastNameController, widget.profesional),
              Container(
                padding: EdgeInsets.only(top: size.height * 0.53),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: _body(size, widget.profesional),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Despliega la interfaz del appbar de la pantalla
  Widget cabeceraPerfilProfesional(
      Size size,
      TextEditingController _nameController,
      TextEditingController _lastNameController,
      Profesional profesional) {
    return Stack(
      children: <Widget>[
        // Draw oval Shape
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: size.height * 0.58,
            width: double.infinity,
            color: kRosado,
          ),
        ),
        // Draw profile picture
        Container(
          padding: EdgeInsets.only(top: size.height * 0.05),
          alignment: Alignment.topCenter,
          child: ClipOval(
            child: Container(
              color: Colors.white,
              width: 200,
              height: 200,
              child: _image == null
                  ? Icon(
                      Icons.account_circle,
                      color: Colors.indigo[100],
                      size: 200,
                    )
                  : Image.network(
                      _image,
                      width: 200,
                      height: 200,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),
            ),
          ),
        ),
        // Draw camera icon
        Container(
          padding: EdgeInsets.only(
              top: (size.height / 2) * 0.45, left: (size.width / 2) * 0.55),
          alignment: Alignment.topCenter,
          child: GestureDetector(
            onTap: () {
              _showPicker(context, profesional);
            },
            child: ClipOval(
              child: Container(
                color: Colors.white,
                width: 43.0,
                height: 43.0,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                  size: 30.0,
                ),
              ),
            ),
          ),
        ),
        // Plus icon and edit text
        Container(
          padding: EdgeInsets.only(top: size.height * 0.33),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => _buildDialog(
                    context, widget.profesional, widget.profesional.uid, size),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.check,
                  size: 20.0,
                  color: kNegro,
                ),
                Text(
                  ' Guardar',
                  style: TextStyle(
                    color: kNegro,
                    fontSize: 15.0,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
              ],
            ),
          ),
        ),

        // Display text name
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 320),
              alignment: Alignment.topCenter,
              child: AutoSizeTextField(
                controller: _nameController,
                textAlign: TextAlign.center,
                fullwidth: false,
                style: TextStyle(
                  color: kNegro,
                  fontSize: (size.height / 2) * 0.06,
                  fontFamily: 'PoppinsRegular',
                ),
                onChanged: (text) {
                  _nameController.text = text;
                  _nameController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _nameController.text.length));
                  widget.profesional.nombre = _nameController.text;
                },
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Container(
              padding: EdgeInsets.only(top: 320),
              alignment: Alignment.topCenter,
              child: AutoSizeTextField(
                controller: _lastNameController,
                textAlign: TextAlign.center,
                fullwidth: false,
                style: TextStyle(
                  color: kNegro,
                  fontSize: (size.height / 2) * 0.06,
                  fontFamily: 'PoppinsRegular',
                ),
                onChanged: (text) {
                  _lastNameController.text = text;
                  _lastNameController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _lastNameController.text.length));
                  widget.profesional.apellido = _lastNameController.text;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Despliega la seccion de la pantalla con la información del usuario
  Widget _body(Size size, Profesional profesional) {
    return Container(
      width: size.width,
      child: Column(
        children: <Widget>[
          _sectionButton(),
          _editSectionCorreo("Correo", _mailController.text),
          _editSection('Ciudad', _cityController ?? '', 1),
          _editSection('Teléfono', _phoneController ?? '', 2),
          _editSection('Convenio', _convenioController ?? '', 3),
          _editSection('Especialidad', _especialidadController ?? '', 4),
          _editSection('Proyectos', _proyectosController ?? '', 5),
          _editSection('Experiencia', _experienciaController ?? '', 6),
          _editSection('Descripción', _descripcionController ?? '', 7),
          Container(
            padding: EdgeInsets.only(right: 15.0, left: 15.0),
            alignment: Alignment.topLeft,
            child: Text(
              "Información Bancaria",
              style: TextStyle(
                fontSize: 24.0,
                color: kRojoOscuro,
                fontFamily: 'PoppinsRegular',
              ),
              textAlign: TextAlign.left,
            ),
          ),
          _editSection('Banco', _bankNameController ?? " ", 8),
          _editSection('Número de Cuenta', _accountNumberController ?? " ", 9),
          _editSection('Tipo de Cuenta', _accountTypeController ?? " ", 10),
        ],
      ),
    );
  }

  /// Despliega la seccion que no es editable
  Widget _editSectionCorreo(String title, String content) {
    return Container(
      padding: EdgeInsets.only(right: 15.0, left: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              color: kRojoOscuro,
              fontFamily: 'PoppinsRegular',
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            content == null ? "Falta información" : content,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 15.0,
              color: kNegro,
              fontFamily: 'PoppinsRegular',
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5.0),
            child: Divider(
              color: Colors.black.withOpacity(0.40),
            ),
          ),
        ],
      ),
    );
  }

  /// Despliega la seccion donde se puede editar
  Widget _editSection(
      String text, TextEditingController controller, int categoria) {
    return Container(
      padding: EdgeInsets.only(right: 15.0, left: 15.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              fontSize: 20.0,
              color: kRojoOscuro,
              fontFamily: 'PoppinsRegular',
            ),
            textAlign: TextAlign.left,
          ),
          TextField(
            controller: controller,
            enableInteractiveSelection: false,
            textAlign: TextAlign.justify,
            minLines: 1,
            maxLines: 10,
            onChanged: (text) {
              controller.text = text;
              controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length));
              if (categoria == 1) {
                widget.profesional.ciudad = controller.text;
              }
              if (categoria == 2) {
                widget.profesional.celular = controller.text;
              }
              if (categoria == 3) {
                widget.profesional.convenios =
                    controller.text.replaceAll("\n", "").split(";");
              }
              if (categoria == 4) {
                widget.profesional.especialidad = controller.text;
              }
              if (categoria == 5) {
                widget.profesional.proyectos =
                    controller.text.replaceAll("\n", "").split(";");
              }
              if (categoria == 6) {
                widget.profesional.experiencia = controller.text;
              }
              if (categoria == 7) {
                widget.profesional.descripcion = controller.text;
              }
              if (categoria == 8) {
                widget.profesional.banco.banco = controller.text;
              }
              if (categoria == 9) {
                widget.profesional.banco.numCuenta = controller.text;
              }
              if (categoria == 10) {
                widget.profesional.banco.tipoCuenta = controller.text;
              }
            },
          ),
        ],
      ),
    );
  }

  /// Sección de password y boton
  Widget _sectionButton() {
    return Container(
      padding: EdgeInsets.only(right: 15.0, left: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Contraseña',
            style: TextStyle(
              fontSize: 20.0,
              color: kRojoOscuro,
              fontFamily: 'PoppinsRegular',
            ),
            textAlign: TextAlign.left,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '*******',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15.0,
                  color: kNegro,
                  fontFamily: 'PoppinsRegular',
                ),
              ),
              Container(
                width: 109.0,
                height: 29.0,
                child: ElevatedButton(
                  child: Text(
                    'Cambiar',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontFamily: 'PoppinsRegular',
                      fontWeight: FontWeight.bold,
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
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                          firebaseAuth.sendPasswordResetEmail(
                              email: firebaseAuth.currentUser.email);
                          return _buildPopupDialog(context);
                        });
                  },
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 5.0),
            child: Divider(
              color: Colors.black.withOpacity(0.40),
            ),
          ),
        ],
      ),
    );
  }

  /// Verificación Asociación de [Profesional] con [Cita]
  Widget _buildDialog(BuildContext context, Profesional profesional,
      String usuario, Size size) {
    Query citasCollection = FirebaseFirestore.instance
        .collection("appoinments")
        .where("professional.uid", isEqualTo: usuario);

    return StreamBuilder<QuerySnapshot>(
        stream: citasCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('ALGO SALIO MAL');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingScreen();
          }
          List<Cita> citas = citaMapToList(snapshot);
          if (citas.length == 0) {
            return modificacionDialogs(context, profesional, size);
          } else {
            return modificacionDialogsCita(context, profesional, citas, size);
          }
        });
  }

  /// Dialogo Confirmación de Modificación de [Profesional] sin [Cita] asociadas.
  Widget modificacionDialogs(
      BuildContext context, Profesional profesional, Size size) {
    String title2 = "";
    String content2 = "";

    return new AlertDialog(
      title: Text(
        'Confirmación de Modificación',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kNegro,
          fontSize: 15.0,
          fontFamily: 'PoppinsRegular',
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        '¿Está seguro que desea modificar\neste perfil?',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kNegro,
          fontSize: 14.0,
          fontFamily: 'PoppinsRegular',
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(37.0),
        side: BorderSide(color: kNegro, width: 2.0),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  editarProfesional(profesional).then((value) {
                    actualizarUsuario(profesional);
                    actualizarProfesional(profesional);
                    bool state;
                    if (value) {
                      title2 = 'Perfil Modificado';
                      content2 = "Su perfil fue modificado exitosamente";
                      state = true;
                    } else {
                      title2 = 'Error de edición';
                      content2 =
                          "Hubo un error guardando los cambios de su perfil, inténtelo nuevamente";
                      state = false;
                    }

                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          adviceDialogProfesional(
                              context, title2, content2, state),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(99.0, 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0),
                    side: BorderSide(color: kNegro),
                  ),
                  shadowColor: Colors.black,
                ),
                child: const Text(
                  'Si',
                  style: TextStyle(
                    color: kNegro,
                    fontSize: 14.0,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.065,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(99.0, 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0),
                    side: BorderSide(color: kNegro),
                  ),
                  shadowColor: Colors.black,
                ),
                child: const Text(
                  'No',
                  style: TextStyle(
                    color: kNegro,
                    fontSize: 14.0,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Dialogo Confirmación de Modificación de [Profesional] con [Cita] asociadas.
  /// Modificación del paciente en la información de las [Cita] asociadas.
  Widget modificacionDialogsCita(BuildContext context, Profesional profesional,
      List<Cita> citas, Size size) {
    String title2 = "";
    String content2 = "";
    return new AlertDialog(
      title: Text(
        'Confirmación de Modificación',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kNegro,
          fontSize: 15.0,
          fontFamily: 'PoppinsRegular',
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        '¿Está seguro que desea modificar\neste perfil?',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kNegro,
          fontSize: 14.0,
          fontFamily: 'PoppinsRegular',
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(37.0),
        side: BorderSide(color: kNegro, width: 2.0),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  citas.forEach((element) {
                    actualizarProfesionalCita(profesional, element);
                  });
                  editarProfesional(profesional).then((value) {
                    actualizarProfesional(profesional);
                    actualizarUsuario(profesional);
                    bool state;
                    if (value) {
                      title2 = 'Perfil Modificado';
                      content2 = "Este perfil fue modificado exitosamente";
                      state = true;
                    } else {
                      title2 = 'Error de edición';
                      content2 =
                          "Hubo un error guardando los cambios de este perfil, inténtelo nuevamente";
                      state = false;
                    }

                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          adviceDialogProfesional(
                              context, title2, content2, state),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(99.0, 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0),
                    side: BorderSide(color: kNegro),
                  ),
                  shadowColor: Colors.black,
                ),
                child: const Text(
                  'Si',
                  style: TextStyle(
                    color: kNegro,
                    fontSize: 14.0,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.065,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(99.0, 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0),
                    side: BorderSide(color: kNegro),
                  ),
                  shadowColor: Colors.black,
                ),
                child: const Text(
                  'No',
                  style: TextStyle(
                    color: kNegro,
                    fontSize: 14.0,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Dialogo de cambiar password
  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: Text('Cambio de Contraseña'),
      content: Text(
        'Hemos enviado las instrucciones de restablecimiento de contraseña a tu correo electrónico.',
        textAlign: TextAlign.justify,
      ),
      actions: <Widget>[
        ElevatedButton(
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

  /// Dialogo confirmacion de cambiar password
  Widget adviceDialogProfesional(
      BuildContext context, String text, String content, bool state) {
    return new AlertDialog(
      title: Text(text),
      content: Text(content),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: kNegro, width: 2.0),
      ),
      actions: <Widget>[
        Center(
          child: ElevatedButton(
            onPressed: () {
              if (state) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              } else if (!state) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(378.0),
                side: BorderSide(color: kNegro),
              ),
              shadowColor: Colors.black,
            ),
            child: const Text(
              'Cerrar',
              style: TextStyle(
                color: kNegro,
                fontSize: 14.0,
                fontFamily: 'PoppinsRegular',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
