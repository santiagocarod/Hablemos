import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/foro.dart';
import 'package:hablemos/model/tema.dart';
import 'package:hablemos/services/providers/foros_provider.dart';
import 'package:hablemos/ux/atoms.dart';

class Forum extends StatelessWidget {
  final Foro foro = ForoProvider.getForo()[0];
  final Tema tema = ForoProvider.getForo()[0].temas[0];

  @override
  Widget build(BuildContext context) {
    //final Tema tema = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBar('', null, 0, null),
      body: Stack(
        children: <Widget>[
          _background(size),
          _appBar(size),
          SingleChildScrollView(
            child: Container(
              height: size.height,
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  _bodyInfoForum(context, size),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
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

  Widget _bodyInfoForum(BuildContext context, Size size) {
    return Expanded(
      child: Column(
        children: <Widget>[
          SizedBox(height: size.height * 0.10),
          _widgetInfoForo(context, size),
          SizedBox(height: 20),
          _widgetBotonesTema(context, size),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 41.0,
            color: kPurpura,
            child: Center(
              child: Text(
                'RESPUESTAS',
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'PoppinsRegular',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ),
          _widgetRespuestasTema(context, size),
        ],
      ),
    );
  }

  Widget _widgetInfoForo(BuildContext context, Size size) {
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Container(
        width: size.width * 0.7,
        height: size.width * 0.4,
        padding: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
        child: Column(
          children: <Widget>[
            Text(
              foro.titulo,
              style: TextStyle(
                fontSize: 25.0,
                fontFamily: 'PoppinsRegular',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              foro.descripcion,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'PoppinsRegular',
                fontSize: 20.0,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(41.0),
          color: kMoradoClarito,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
              spreadRadius: 0.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _widgetBotonesTema(BuildContext context, Size size) {
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
                Navigator.pushNamed(context, 'response', arguments: foro);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    size: 20.0,
                  ),
                  Text(
                    ' Responder',
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

  Widget _widgetRespuestasTema(BuildContext context, Size size) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        itemCount: tema.respuestas.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: size.width * 0.7,
                  child: Text(
                    'Holaaaaaaaaaaaaaaaaaaaaaaaaaa',
                    style: TextStyle(
                      fontFamily: 'PoppinsRegular',
                      fontSize: 15.0,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => _optionDialog(context),
                    );
                  },
                  child: Icon(Icons.more_horiz),
                ),
              ],
            ),
          );
        },
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
            '¿Está seguro que desea eliminar\neste foro?',
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
        'Foro Eliminado',
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

  Widget _optionDialog(BuildContext context) {
    return SizedBox(
      width: 211.0,
      height: 79.0,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
          side: BorderSide(color: kNegro, width: 2.0),
        ),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  height: 40.0,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Eliminar',
                      style: TextStyle(
                        color: kNegro,
                        fontSize: 15.0,
                        fontFamily: 'PoppinsRegular',
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Divider(
                    color: Colors.black.withOpacity(0.40),
                  ),
                ),
                Container(
                  height: 40.0,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'viewResponse');
                    },
                    child: const Text(
                      'Ver Respuesta',
                      style: TextStyle(
                        color: kNegro,
                        fontSize: 15.0,
                        fontFamily: 'PoppinsRegular',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
