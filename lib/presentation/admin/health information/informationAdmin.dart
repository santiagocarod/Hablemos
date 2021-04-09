import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/trastorno.dart';
import 'package:hablemos/services/providers/trastornos_provider.dart';
import 'package:hablemos/ux/atoms.dart';

class InformationAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final Trastorno trastorno = ModalRoute.of(context).settings.arguments;
    final Trastorno trastorno = TrastornoProvider.getTrastorno()[0];
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBar('', null, 0, null),
      body: Stack(
        children: <Widget>[
          _background(size),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                _appBar(size),
                _detail(context, size, trastorno),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _background(Size size) {
    return Image.asset(
      'assets/images/purpleBackground.png',
      alignment: Alignment.center,
      fit: BoxFit.fill,
      width: size.width,
      height: size.height,
    );
  }

  Widget _appBar(Size size) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: size.height * 0.05, bottom: 10.0),
        child: Column(
          children: <Widget>[
            Text(
              'Foros',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'PoppinsRegular',
                fontSize: 21.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detail(BuildContext context, Size size, Trastorno trastorno) {
    String name = trastorno.nombre.toUpperCase();
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(height: size.height * 0.05),
          Container(
            width: size.width,
            height: 51.13,
            color: kPurpura,
            child: Center(
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: kNegro,
                  fontFamily: 'PoppinsRegular',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ),
          _simpleSecction('Definición', trastorno.definicion, size),
          _listSecction('Síntomas', trastorno.sintomas, size),
          _simpleSecction(
              'Autoayuda y Afrontamiento', trastorno.autoayuda, size),
          _listSecction('Fuente Información', trastorno.fuentes, size),
          _buttons(context, size, trastorno),
        ],
      ),
    );
  }

  Widget _simpleSecction(String title, String content, Size size) {
    return Container(
      padding: EdgeInsets.only(right: 10.0, left: 10.0),
      width: size.width,
      height: size.height * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
                color: kMoradoTitulo,
                fontFamily: 'PoppinsRegular',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(
                content,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 17.0,
                  color: kNegro,
                  fontFamily: 'PoppinsRegular',
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Divider(
              color: Colors.black.withOpacity(0.40),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listSecction(String title, List<String> content, Size size) {
    return Container(
      padding: EdgeInsets.only(right: 10.0, left: 10.0),
      width: size.width,
      height: size.height * 0.20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
                color: kMoradoTitulo,
                fontFamily: 'PoppinsRegular',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _list(content),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Divider(
              color: Colors.black.withOpacity(0.40),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _list(List<String> content) {
    List<Widget> info = [];
    content.forEach((element) {
      Text inf = Text(
        element,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: 17.0,
          color: kNegro,
          fontFamily: 'PoppinsRegular',
        ),
      );
      info.add(inf);
    });

    return info;
  }

  Widget _buttons(BuildContext context, Size size, Trastorno trastorno) {
    return Container(
      width: size.width,
      height: size.height * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(left: 15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'newInformation',
                    arguments: trastorno);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    size: 20.0,
                  ),
                  Text(
                    ' Modificar',
                    style: TextStyle(
                      fontFamily: 'PoppinsRegular',
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () => _mostrarAlert(context),
              child: Row(
                children: [
                  Icon(
                    Icons.remove_circle_outline_outlined,
                    size: 20.0,
                  ),
                  Text(
                    ' Eliminar',
                    style: TextStyle(
                      fontFamily: 'PoppinsRegular',
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _mostrarAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Confirmación de Eliminación',
            style: TextStyle(
              color: kNegro,
              fontSize: 15.0,
              fontFamily: 'PoppinsRegular',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            '¿Está seguro que desea eliminar\nesta información?',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => _adviceDialog(context),
                    );
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
      },
    );
  }

  // Confirm popup dialog
  Widget _adviceDialog(BuildContext context) {
    return new AlertDialog(
      title: Text(
        'Información Eliminada',
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: kNegro, width: 2.0),
      ),
      actions: <Widget>[
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
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
