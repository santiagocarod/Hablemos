import 'package:flutter/material.dart';
import 'package:hablemos/business/admin/negocioDiagnosticos.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/diagnostico.dart';
import 'package:hablemos/ux/atoms.dart';

///Clase encargada de recolectar la información de un nuevo Diagnostico
///
///En caso de que se reciba como argumento un [Diagnostico] se trata de una modificación
///En caso de que este atributo [trastorno] sea `null` es un [Diagnostico] nuevo
class NewInformation extends StatefulWidget {
  final Diagnostico trastorno;
  NewInformation({this.trastorno});

  @override
  _NewInformation createState() => _NewInformation();
}

/// Para cada campo de texto se tiene un [TextEditinController]
class _NewInformation extends State<NewInformation> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _definitionController = new TextEditingController();
  TextEditingController _symptomController = new TextEditingController();
  TextEditingController _helpController = new TextEditingController();
  TextEditingController _sourceController = new TextEditingController();

  ///En caso de ser una modificación se debe inicializar los controladores
  @override
  void initState() {
    super.initState();

    if (widget.trastorno != null) {
      _nameController.text = widget.trastorno.nombre;
      _definitionController.text = widget.trastorno.definicion;
      _symptomController.text = _convert(widget.trastorno.sintomas);
      _helpController.text = widget.trastorno.autoayuda;
      _sourceController.text = _convert(widget.trastorno.fuentes);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    _detail(context, size, widget.trastorno),
                    SizedBox(
                      height: 35.0,
                    ),
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
              'Diagnosticos',
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

  ///Formulario de datos para crear un [Diagnostico nuevo]
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
            child: _nameSection(_nameController),
          ),
          _secction('Definición', _definitionController, size),
          _secction('Síntomas (Separados por ";")', _symptomController,
              size), // Modelo separar por enter y agregar en una lista
          _secction('Autoayuda y Afrontamiento', _helpController, size),
          _secction('Fuente Información (Separados por ";")', _sourceController,
              size), // Modelo separar por enter y agregar en una lista
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              trastorno != null ? _buttonEliminar(size, trastorno) : Text(""),
              _button(size, trastorno),
            ],
          ),
        ],
      ),
    );
  }

  ///Sección especifica para ingresar el nombre del [Diagnostico]
  Widget _nameSection(TextEditingController controller) {
    return Center(
      child: TextField(
        controller: controller,
        enableInteractiveSelection: false,
        keyboardType: TextInputType.multiline,
        textAlign: TextAlign.center,
        decoration: InputDecoration(hintText: "Nombre del Diagnostico"),
        style: TextStyle(
          fontSize: 20.0,
          color: kNegro,
          fontFamily: 'PoppinsRegular',
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
        ),
      ),
    );
  }

  ///Seccion general para la recolección de datos para el [Diagnostico]
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

  ///Función dedicada a la conversion de una lista en una cadena de caracteres
  String _convert(List<String> content) {
    String aux = "";
    content.forEach((element) {
      aux += element + ";\n ";
    });

    return aux;
  }

  ///El botón encargado de guardar la información
  ///
  ///En caso de que [trastorno] sea `null` entonces el Botón dice "Crear", en caso contrario dice "Actualizar"
  ///La información que son listas las divide por el caracter `;`.
  ///En caso de ser una actualización se envia la información al método [actualizarDiagnostico()]
  ///En caso de ser una creación se envia la información al método [agregarDiagnostico()]
  Widget _button(Size size, Diagnostico trastorno) {
    String text = 'Información Creada';
    String button = ' Crear';
    if (trastorno != null) {
      button = ' Actualizar';
      text = 'Información Actualizada';
    }
    return Container(
      padding: EdgeInsets.only(top: 30.0, right: 20.0),
      child: GestureDetector(
        onTap: () {
          Diagnostico diagnostico = Diagnostico(
              definicion: _definitionController.text,
              nombre: _nameController.text,
              autoayuda: _helpController.text,
              fuentes: _sourceController.text != ""
                  ? _sourceController.text.replaceAll("\n", "").split(";")
                  : [],
              sintomas: _symptomController.text != ""
                  ? _symptomController.text.replaceAll("\n", "").split(";")
                  : []);
          if (_definitionController.text == "" || _nameController.text == "") {
            showDialog(
              context: context,
              builder: (BuildContext context) => _errorDialog(context,
                  "Por favor ingrese información de\n nombre y descripción."),
            );
          } else {
            if (trastorno == null) {
              if (!agregarDiagnostico(diagnostico)) {
                text = 'Ocurrió un Error inténtalo más tarde';
              }
            } else {
              diagnostico.id = trastorno.id;
              if (!actualizarDiagnostico(diagnostico)) {
                text = 'Ocurrió un Error inténtelo más tarde.';
              }
            }
            showDialog(
              context: context,
              builder: (BuildContext context) => _adviceDialog(context, text),
            );
          }
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

  ///Botón encargado de recibir el evento cuando el administrador quiera Eliminar el [Diagnostico]
  ///
  ///Debe mostrar un dialogo [dialogoConfirmacion()] para confirmar que este seguro de realizar la acción
  Widget _buttonEliminar(Size size, Diagnostico trastorno) {
    String button = 'Eliminar';

    return Container(
      padding: EdgeInsets.only(top: 30.0, left: 20.0),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return dialogoConfirmacion(
                    context,
                    "mainInformation",
                    "Confirmacion Eliminación",
                    "¿Esta seguro que quiere eliminar este diagnostico? ",
                    eliminarDiagnostico,
                    parametro: trastorno);
              });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.delete,
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

  ///Dialogo de confirmación que la acción fue realizada
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

  ///Dialogo de error en caso de que se presente alguno
  Widget _errorDialog(BuildContext context, String text) {
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
