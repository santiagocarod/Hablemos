import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/diagnostico.dart';
import 'package:hablemos/ux/atoms.dart';

/// Clase encargada de desplegar informacion especifica de un [Diagnostico]
///
/// Muestra toda la información para un solo [Diagnostico]
class InformationAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Diagnostico diagnostico = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;

    return Container(
      color: kMoradoClarito,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: crearAppBar('', null, 0, null, context: context),
          body: Stack(
            children: <Widget>[
              _background(size),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    _appBar(size),
                    _detail(context, size, diagnostico),
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

///Mostrar Fondo
Widget _background(Size size) {
  return Image.asset(
    'assets/images/purpleBackground.png',
    alignment: Alignment.center,
    fit: BoxFit.fill,
    width: size.width,
    height: size.height,
  );
}

///Mostrar AppBar
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

///Mostrar el detalle especifico.
Widget _detail(BuildContext context, Size size, Diagnostico diagnostico) {
  String name = diagnostico.nombre.toUpperCase();
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
        _simpleSecction('Definición', diagnostico.definicion, size),
        _listSecction('Síntomas', diagnostico.sintomas, size),
        _simpleSecction(
            'Autoayuda y Afrontamiento', diagnostico.autoayuda, size),
        _listSecction('Fuente Información', diagnostico.fuentes, size),
        _buttons(context, size, diagnostico),
      ],
    ),
  );
}

///Sección simple de algun campo del [Diagnostico]
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

///Sección en forma de lista del [Diagnostico]
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

///Retorna una lista de [Text] por cada elemento de la lista
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

///Widget que despliega los botones de Editar o Eliminar el [Diagnostico]
///
///En caso de querer modificar se envia a [NewInformation()] pero con un argumento que es el [diagnostico] el cual se quiere modificar.
Widget _buttons(BuildContext context, Size size, Diagnostico diagnostico) {
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
                  arguments: diagnostico);
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

/// En caso de que se ejecute alguna acción que requiera de la confirmación del usuario
///
/// Se desplegará en pantalla un mensaje de confirmación.
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

// Dialogo final de confirmación de que se realizó la acción
Widget _adviceDialog(BuildContext context) {
  return new AlertDialog(
    title: Text(
      '¡Información Eliminada!',
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
