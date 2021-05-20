import 'package:flutter/material.dart';
import 'package:hablemos/business/admin/negocioEventos.dart';
import 'package:hablemos/business/cloudinary.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/grupo.dart';
import 'package:hablemos/model/participante.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:image_picker/image_picker.dart';

/// Clase que permite subir el comprobate de pago a un [Grupo]
///
/// Este pago es necesario cuando el Evento es virtual y Pago
class AttachPaymentGroup extends StatefulWidget {
  @override
  _AttachPaymentGroupState createState() => _AttachPaymentGroupState();
}

class _AttachPaymentGroupState extends State<AttachPaymentGroup> {
  String _image;
  final ImagePicker _imagePicker = new ImagePicker();

  _imagenDesdeCamara(Participante participante) async {
    PickedFile image = await _imagePicker.getImage(
        source: ImageSource.camera, imageQuality: 50);

    uploadImage(image.path, GROUP_PAYMENT).then((value) {
      if (value != null) {
        _image = value;
        participante.pago = value;
        Navigator.pop(context);
        setState(() {});
      } else {
        showAlertDialog(
            context, "Hubo un error subiendo la foto, inténtalo nuevamente.");
      }
    });
  }

  _imagenDesdeGaleria(Participante participante) async {
    PickedFile image = await _imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);

    uploadImage(image.path, GROUP_PAYMENT).then((value) {
      if (value != null) {
        _image = value;
        participante.pago = value;
        Navigator.pop(context);
        setState(() {
          build(context);
        });
      } else {
        showAlertDialog(
            context, "Hubo un error subiendo la foto, inténtalo nuevamente.");
      }
    });
  }

  void _showPicker(context, participante) {
    if (_image != null) {
      deleteImage(_image);
    }
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
                        _imagenDesdeGaleria(participante);
                        //Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Cámara'),
                    trailing: new Icon(Icons.cloud_upload),
                    onTap: () {
                      _imagenDesdeCamara(participante);
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
    final Map<String, dynamic> aux = ModalRoute.of(context).settings.arguments;
    final Grupo grupo = aux["grupo"];
    final Participante participante = aux["participante"];
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          child: Image.asset(
            'assets/images/eventsPaymentBackground.png',
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
            appBar:
                crearAppBar("Adjuntar Pago", null, 0, null, context: context),
            body: Stack(children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: size.height * 0.15,
                    ),
                    Container(
                      height: size.height * 0.1,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          _showPicker(context, participante);
                        },
                        child: Container(
                            height: 46,
                            width: 196,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: kBlanco,
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 0),
                                    blurRadius: 7.0,
                                    color: Colors.grey.withOpacity(0.5)),
                              ],
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text("SUBIR IMAGEN",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: "PoppinSemiBold",
                                          letterSpacing: 2,
                                          color: kNegro)),
                                  Icon(
                                    Icons.cloud_upload,
                                    color: kNegro,
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                    _image == null
                        ? SizedBox(
                            height: size.height * 0.25,
                          )
                        : Padding(
                            padding: const EdgeInsets.all(20),
                            child: Image.network(
                              _image,
                              height: size.height / 2,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                    GestureDetector(
                      onTap: () {
                        if (participante.pago != null) {
                          if (agregarParticipanteGrupo(participante, grupo)) {
                            showDialog(
                                context: context,
                                builder: (BuildContext contex) =>
                                    _buildPopupDialog(context, "¡Exito!",
                                        "¡Inscripción Correcta!", grupo,
                                        ruta: "grupoSubscripto"));
                          }
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext contex) =>
                                  _buildPopupDialog(context, "¡Fallo!",
                                      "Agregue la foto del pago.", grupo));
                        }
                      },
                      child: Container(
                        height: 55,
                        width: 296,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: kMoradoClarito,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 7.0,
                                color: Colors.grey.withOpacity(0.5)),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "ENVIAR COMPROBANTE",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "PoppinSemiBold",
                                letterSpacing: 2.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

/// Dialogo de confirmación de envio de pago
Widget _buildPopupDialog(
    BuildContext context, String tittle, String content, Grupo grupo,
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
            Navigator.pushNamed(context, ruta, arguments: grupo);
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
