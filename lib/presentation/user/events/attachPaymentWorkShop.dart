import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/taller.dart';
import 'package:hablemos/ux/atoms.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AttachPaymentWorkShop extends StatefulWidget {
  @override
  _AttachPaymentWorkShopState createState() => _AttachPaymentWorkShopState();
}

class _AttachPaymentWorkShopState extends State<AttachPaymentWorkShop> {
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
    final Taller taller = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: crearAppBar("Adjuntar Pago", null, 0, null),
      body: Stack(children: [
        Image.asset(
          'assets/images/eventsPaymentBackground.png',
          alignment: Alignment.center,
          fit: BoxFit.fill,
          width: size.width,
          height: size.height,
        ),
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: size.height * 0.05,
              ),
              Center(
                child: Text(
                  "Adjunte una Imagen del Pago Realizado",
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 25.0, fontFamily: "PoppinsRegular"),
                ),
              ),
              Container(
                height: size.height * 0.1,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _showPicker(context);
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      child: Image.file(
                        _image,
                        height: size.height / 2,
                      ),
                    ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "tallerSubscripto",
                      arguments: taller);
                },
                child: Container(
                  height: 55,
                  width: 296,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: kMoradoClaro,
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
    );
  }
}
