import 'package:flutter/material.dart';
import 'package:hablemos/business/cloudinary.dart';
import 'package:hablemos/business/pacient/negocioCitas.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:image_picker/image_picker.dart';

class AttatchPayment extends StatefulWidget {
  @override
  _AttatchPaymentState createState() => _AttatchPaymentState();
}

class _AttatchPaymentState extends State<AttatchPayment> {
  String _image;
  final ImagePicker _imagePicker = new ImagePicker();

  _imagenDesdeCamara(Cita cita) async {
    PickedFile image = await _imagePicker.getImage(
        source: ImageSource.camera, imageQuality: 50);

    uploadImage(image.path, PAY_FOLDER).then((value) {
      if (value != null) {
        actualizarPago(cita, value).then((val) {
          if (val) {
            _image = value;
            Navigator.pop(context);
            setState(() {});
          } else {
            showAlertDialog(context,
                "Hubo un error enviando la foto, inténtalo nuevamente.");
          }
        });
      }
    });
  }

  _imagenDesdeGaleria(Cita cita) async {
    PickedFile image = await _imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);

    uploadImage(image.path, PAY_FOLDER).then((value) {
      if (value != null) {
        actualizarPago(cita, value).then((val) {
          if (val) {
            _image = value;
            Navigator.pop(context);
            setState(() {});
          } else {
            showAlertDialog(context,
                "Hubo un error enviando la foto, inténtalo nuevamente.");
          }
        });
      }
    });
  }

  void _showPicker(context, cita) {
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
                        _imagenDesdeGaleria(cita);
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Cámara'),
                    trailing: new Icon(Icons.cloud_upload),
                    onTap: () {
                      _imagenDesdeCamara(cita);
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
    final Cita cita = ModalRoute.of(context).settings.arguments;
    if (cita.pago != null && cita.pago != "") {
      _image = cita.pago;
    }
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          child: Image.asset(
            'assets/images/yellowBack.png',
            alignment: Alignment.center,
            fit: BoxFit.fill,
            width: size.width,
            height: size.height,
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar:
                crearAppBar("Adjuntar Pago", null, 0, null, context: context),
            body: Stack(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _image == null
                      ? SizedBox(
                          height: 10,
                        )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Image.network(
                              _image,
                              height: size.height / 1.5,
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
                        ),
                  _image == null
                      ? Center(
                          child: iconButtonBig("Subir prueba de pago", () {
                            _showPicker(context, cita);
                          }, Icons.cloud_upload, Colors.yellow[700]),
                        )
                      : SizedBox(
                          height: 10,
                        ),
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
