import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/centro_atencion.dart';
import 'package:hablemos/ux/EncabezadoMedical.dart';
import 'package:hablemos/ux/atoms.dart';

class ListMedicalCenter extends StatefulWidget {
  @override
  _ListMedicalCenterState createState() => _ListMedicalCenterState();
}

class _ListMedicalCenterState extends State<ListMedicalCenter> {
  //final _medicalCenters = CentroAtencionProvider.getCentros();

  Position _currentPosition;
  double dirLatitud;
  double dirLongitud;
  List<CentroAtencion> listaCercanosReal;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    print(_currentPosition);
    Size size = MediaQuery.of(context).size;

    List<CentroAtencion> _medicalCenters =
        ModalRoute.of(context).settings.arguments;
    return Container(
      color: kRosado,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: crearAppBar('', null, 0, null, context: context),
            body: Column(
              children: <Widget>[
                EncabezadoMedical(size: size, text1: "Canales de Ayuda"),
                Espacio(size: size),
                Container(
                  width: size.width - 20,
                  color: kRosado,
                  child: Center(
                    child: Text("Lineas de ayuda",
                        style: TextStyle(
                            color: kLetras,
                            fontSize: 26,
                            fontFamily: "PoppinsRegular")),
                  ),
                ),
                Espacio(size: size),
                Expanded(
                    child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  children: centersToWidgets(context, _medicalCenters),
                ))
              ],
            )),
      ),
    );
  }

  List<Widget> centersToWidgets(
      BuildContext context, List<CentroAtencion> _medicalCenters) {
    List<Widget> widgets = [];
    _medicalCenters.forEach((element) {
      Card card = Card(
        child: Container(
            height: 80,
            child: Center(
                child: Text(
              element.nombre,
              style: TextStyle(
                  color: kLetras, fontSize: 22, fontFamily: "PoppinsRegular"),
            ))),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
      );

      InkWell inkWell = InkWell(
        splashColor: kAmarillo,
        onTap: () {
          Navigator.pushNamed(context, "detailCentroMedico",
              arguments: element);
        },
        child: card,
      );
      widgets.add(inkWell);
    });

    return widgets;
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
}
