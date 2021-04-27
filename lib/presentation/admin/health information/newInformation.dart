import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/diagnostico.dart';
import 'package:hablemos/ux/atoms.dart';

class NewInformation extends StatefulWidget {
  @override
  _NewInformation createState() => _NewInformation();
}

class _NewInformation extends State<NewInformation> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _definitionController = new TextEditingController();
  TextEditingController _symptomController = new TextEditingController();
  TextEditingController _helpController = new TextEditingController();
  TextEditingController _sourceController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Diagnostico trastorno = ModalRoute.of(context).settings.arguments;

    // Validates if it is update or creation
    if (trastorno != null) {
      _nameController.text = trastorno.nombre;
      _definitionController.text = trastorno.definicion;
      _symptomController.text = _convert(trastorno.sintomas);
      _helpController.text = trastorno.autoayuda;
      _sourceController.text = _convert(trastorno.fuentes);
    } else if (trastorno == null) {
      _nameController.text = "NOMBRE TRASTORNO";
    }

    return Container(
      color: kMoradoClarito,
      child: SafeArea(
        child: Scaffold(
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
        ),
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

  Widget _detail(BuildContext context, Size size, Diagnostico trastorno) {
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
              child: TextField(
                controller: _nameController,
                enableInteractiveSelection: false,
                keyboardType: TextInputType.multiline,
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
          _secction('Definición', _definitionController, size),
          _secction('Síntomas', _symptomController,
              size), // Modelo separar por enter y agregar en una lista
          _secction('Autoayuda y Afrontamiento', _helpController, size),
          _secction('Fuente Información', _sourceController,
              size), // Modelo separar por enter y agregar en una lista
          _button(size, trastorno),
        ],
      ),
    );
  }

  Widget _secction(String title, TextEditingController controller, Size size) {
    return Container(
      padding: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
      width: size.width,
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
          TextField(
            controller: controller,
            enableInteractiveSelection: false,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 17.0,
              color: kNegro,
              fontFamily: 'PoppinsRegular',
            ),
          ),
        ],
      ),
    );
  }

  String _convert(List<String> content) {
    String aux = "";
    content.forEach((element) {
      aux += element + "\n";
    });

    return aux;
  }

  Widget _button(Size size, Diagnostico trastorno) {
    String text = 'Información Creada';
    String button = ' Crear';
    // Chage the text of button if it is an update
    if (trastorno != null) {
      button = ' Actualizar';
      text = 'Información Actualizada';
    }
    return Container(
      padding: EdgeInsets.only(top: 30.0, right: 20.0),
      child: GestureDetector(
        onTap: () {
          // TODO: Save information
          showDialog(
            context: context,
            builder: (BuildContext context) => _adviceDialog(context, text),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.save,
              size: 25.0,
            ),
            Text(
              button,
              style: TextStyle(
                fontFamily: 'PoppinsRegular',
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Confirm popup dialog
  Widget _adviceDialog(BuildContext context, String text) {
    return AlertDialog(
      title: Text(
        text,
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
