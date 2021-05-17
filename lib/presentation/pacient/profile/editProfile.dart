import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hablemos/business/cloudinary.dart';
import 'package:hablemos/business/pacient/negocioPaciente.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/paciente.dart';
import 'package:hablemos/util/snapshotConvertes.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/ux/loading_screen.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfile createState() => _EditProfile();
  final Paciente paciente;
  const EditProfile({this.paciente});
}

class _EditProfile extends State<EditProfile> {
  TextEditingController _mailController = new TextEditingController();
  TextEditingController _cityController = new TextEditingController();
  TextEditingController _dateController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _nameEController = new TextEditingController();
  TextEditingController _phoneEController = new TextEditingController();
  TextEditingController _relationController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _lastnameController = new TextEditingController();
  String _image;
  final ImagePicker _imagePicker = new ImagePicker();

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController()
      ..text = widget.paciente.fechaNacimiento;

    _mailController = TextEditingController()..text = widget.paciente.correo;
    _cityController = TextEditingController()..text = widget.paciente.ciudad;
    _phoneController = TextEditingController()..text = widget.paciente.telefono;
    _nameEController = TextEditingController()
      ..text = widget.paciente.nombreContactoEmergencia;
    _phoneEController = TextEditingController()
      ..text = widget.paciente.telefonoContactoEmergencia;
    _relationController = TextEditingController()
      ..text = widget.paciente.relacionContactoEmergencia;
    _nameController = TextEditingController()..text = widget.paciente.nombre;
    _lastnameController = TextEditingController()
      ..text = widget.paciente.apellido;
    _image = widget.paciente.foto;
  }

  // Set the image form camera
  _imagenDesdeCamara(Paciente paciente) async {
    PickedFile image = await _imagePicker.getImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      uploadImage(image.path, PROFILE_FOLDER).then((value) {
        if (value != null) {
          actualizarPerfil(paciente, value).then((val) {
            if (paciente.foto != "falta foto") {
              deleteImage(paciente.foto);
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

  // Set the image form gallery
  _imagenDesdeGaleria(Paciente paciente) async {
    PickedFile image = await _imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);

    uploadImage(image.path, PROFILE_FOLDER).then((value) {
      if (value != null) {
        actualizarPerfil(paciente, value).then((val) {
          if (paciente.foto != "falta foto") {
            deleteImage(paciente.foto);
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

  // Display options (Camera or Gallery)
  void _showPicker(context, paciente) {
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
                        _imagenDesdeGaleria(paciente);
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Cámara'),
                    trailing: new Icon(Icons.cloud_upload),
                    onTap: () {
                      _imagenDesdeCamara(paciente);
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
    final FirebaseAuth auth = FirebaseAuth.instance; //OBTENER EL USUARIO ACTUAL
    final User user = auth.currentUser;

    return Container(
      color: kRosado,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          // Create an empty appBar, display the arrow back
          appBar: crearAppBar('', null, 0, null, context: context),
          body: Stack(
            children: <Widget>[
              pacientHead(size, _nameController, _lastnameController, user,
                  widget.paciente),
              Container(
                padding: EdgeInsets.only(top: (size.height / 2) + 70.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: _body(size, widget.paciente),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Draw app bar Style
  Widget pacientHead(Size size, TextEditingController textNombre,
      TextEditingController textApellido, User user, Paciente paciente) {
    return Stack(
      children: <Widget>[
        // Draw oval Shape
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: (size.height / 2) + 80.0,
            width: double.infinity,
            color: kRosado,
          ),
        ),
        // Draw profile picture
        Container(
          padding: EdgeInsets.only(top: 32),
          alignment: Alignment.topCenter,
          child: ClipOval(
            child: Container(
              color: Colors.white,
              width: 200.0,
              height: 200.0,
              child: _image == "falta foto"
                  ? Icon(
                      Icons.account_circle,
                      color: Colors.indigo[100],
                      size: 200.0,
                    )
                  : Image.network(
                      _image,
                      width: 200.0,
                      height: 200.0,
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
              _showPicker(context, paciente);
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
        // Check icon and save text
        Container(
          margin: EdgeInsets.only(top: 253.0),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    _buildDialog(context, widget.paciente, user, size),
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
              padding: EdgeInsets.only(top: 283),
              alignment: Alignment.topCenter,
              child: AutoSizeTextField(
                controller: textNombre,
                textAlign: TextAlign.center,
                enableInteractiveSelection: false,
                fullwidth: false,
                style: TextStyle(
                  color: kNegro,
                  fontSize: (size.height / 2) * 0.06,
                  fontFamily: 'PoppinsRegular',
                ),
                onChanged: (text) {
                  textNombre.text = text;
                  textNombre.selection = TextSelection.fromPosition(
                      TextPosition(offset: textNombre.text.length));
                  widget.paciente.nombre = textNombre.text;
                },
              ),
            ),
            SizedBox(width: 10.0),
            Container(
              padding: EdgeInsets.only(top: 283),
              alignment: Alignment.topCenter,
              child: AutoSizeTextField(
                controller: textApellido,
                textAlign: TextAlign.center,
                enableInteractiveSelection: false,
                fullwidth: false,
                style: TextStyle(
                  color: kNegro,
                  fontSize: (size.height / 2) * 0.06,
                  fontFamily: 'PoppinsRegular',
                ),
                onChanged: (text) {
                  textApellido.text = text;
                  textApellido.selection = TextSelection.fromPosition(
                      TextPosition(offset: textApellido.text.length));
                  widget.paciente.apellido = textApellido.text;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  //Body of the screen
  Widget _body(Size size, Paciente paciente) {
    return Container(
      width: size.width,
      child: Column(
        children: <Widget>[
          _nonEditSection('Correo', _mailController.text),
          _sectionButton(),
          _editSection('Ciudad', _cityController, 1),
          _nonEditSection('Fecha de Nacimiento', _dateController.text),
          _editSection('Teléfono', _phoneController, 2),
          Container(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(
              'Información Contacto de Emergencia',
              style: TextStyle(
                fontSize: 20.0,
                color: kRojoOscuro,
                fontFamily: 'PoppinsRegular',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          _editSection('Nombre', _nameEController, 3),
          _editSection('Teléfono', _phoneEController, 4),
          _editSection('Relación', _relationController, 5),
        ],
      ),
    );
  }

  //Section non editable
  Widget _nonEditSection(String title, String content) {
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

  // Section: title and text field
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
            onChanged: (text) {
              controller.text = text;
              controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length));
              if (categoria == 1) {
                widget.paciente.ciudad = controller.text;
              }
              if (categoria == 2) {
                widget.paciente.telefono = controller.text;
              }
              if (categoria == 3) {
                widget.paciente.nombreContactoEmergencia = controller.text;
              }
              if (categoria == 4) {
                widget.paciente.telefonoContactoEmergencia = controller.text;
              }
              if (categoria == 5) {
                widget.paciente.relacionContactoEmergencia = controller.text;
              }
            },
            controller: controller,
            enableInteractiveSelection: false,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  // Verificación Asociación de Paciente con Citas
  Widget _buildDialog(
      BuildContext context, Paciente paciente, User user, Size size) {
    Query reference = FirebaseFirestore.instance
        .collection("appoinments")
        .where('pacient.uid', isEqualTo: user.uid);

    return StreamBuilder<QuerySnapshot>(
        stream: reference.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('ALGO SALIO MAL');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingScreen();
          }
          List<Cita> citas = citaMapToList(snapshot);
          if (citas.length == 0) {
            return modificacionDialogs(paciente, paciente.uid, size);
          } else {
            return modificacionDialogsCita(paciente, paciente.uid, citas, size);
          }
        });
  }

  // Dialogo Confirmación de Modificación de Paciente sin Citas asociadas.
  Widget modificacionDialogs(Paciente paciente, String user, Size size) {
    String title2 = "";
    String content2 = "";
    return new AlertDialog(
      title: Text(
        'Confirmación de Modificación',
        style: TextStyle(
          color: kNegro,
          fontSize: 15.0,
          fontFamily: 'PoppinsRegular',
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        '¿Está seguro que desea modificar\neste perfil?',
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                editarPaciente(paciente).then((value) {
                  actualizarUsuario(paciente);
                  bool state;
                  if (value) {
                    title2 = 'Perfil modificada';
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
                        adviceDialogPacient(context, title2, content2, state),
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
      ],
    );
  }

  // Dialogo Confirmación de Modificación de Paciente con Citas asociadas.
  // Modificación del paciente en la información de las Citas asociadas.
  Widget modificacionDialogsCita(
      Paciente paciente, String user, List<Cita> citas, size) {
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
                    actualizarPacienteCita(paciente, element);
                  });
                  editarPaciente(paciente).then((value) {
                    actualizarUsuario(paciente);
                    bool state;
                    if (value) {
                      title2 = '¡Perfil modificada!';
                      content2 = "¡Tu perfil fue modificado exitosamente!";
                      state = true;
                    } else {
                      title2 = 'Error de edición';
                      content2 =
                          "Hubo un error guardando los cambios de tu perfil, inténtalo nuevamente.";
                      state = false;
                    }

                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          adviceDialogPacient(context, title2, content2, state),
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

  // Password section and button
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
                      },
                    );
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

  // Change password popup dialog
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

  // Confirm popup dialog
  Widget adviceDialogPacient(
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
