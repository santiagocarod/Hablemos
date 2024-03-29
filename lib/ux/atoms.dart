import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/inh_widget.dart';
import 'package:hablemos/model/carta.dart';
import 'package:hablemos/ux/shape_appbar_border.dart';
import 'package:hablemos/constants.dart';

import '../constants.dart';

///Este documento contiene los widgets que son usados en diferentes pantallas, asi que aca estan ya definidos
/// Evitando diferentes diseños

/// Widget que contiene el boton grande de bloc
Widget iconButtonBigBloc(String text, Function function, IconData iconData,
    Color color, InputsBloc bloc) {
  return StreamBuilder(
    stream: bloc.formValidStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton.icon(
        onPressed: snapshot.hasData ? function : null,
        label: Text(text, style: TextStyle(fontSize: 20)),
        icon: Padding(
            padding: EdgeInsets.only(left: 10, top: 20, right: 20, bottom: 20),
            child: Icon(iconData)),
        style: ElevatedButton.styleFrom(
            primary: color,
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
      );
    },
  );
}

/// Widget que contiene el diseño de uno de los botones de la aplicacion
Widget iconButtonBig(
    String text, Function function, IconData iconData, Color color) {
  return ElevatedButton.icon(
    onPressed: function,
    label: Text(text, style: TextStyle(fontSize: 20)),
    icon: Padding(
        padding: EdgeInsets.only(left: 10, top: 20, right: 20, bottom: 20),
        child: Icon(iconData)),
    style: ElevatedButton.styleFrom(
        primary: color,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
  );
}

/// Widget que contiene el diseño de uno de los botones de la aplicacion
Widget iconButtonSmall(
    {String text, Function function, IconData iconData, Color color}) {
  return ElevatedButton.icon(
    onPressed: function,
    label: Text(text, style: TextStyle(fontSize: 20)),
    icon: Padding(
        padding: EdgeInsets.only(left: 10, top: 20, right: 20, bottom: 20),
        child: Icon(iconData)),
    style: ElevatedButton.styleFrom(
        primary: color,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
  );
}

/// Widget que contiene el diseño de uno de los botones de la aplicacion
Widget iconButtonXs(
    {String text, Function function, IconData iconData, Color color}) {
  return ElevatedButton.icon(
    onPressed: function,
    label: Text(text, style: TextStyle(fontSize: 16)),
    icon: Padding(
        padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
        child: Icon(iconData)),
    style: ElevatedButton.styleFrom(
        primary: color,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
  );
}

/// Widget que contiene el diseño de uno de los botones de la aplicacion
Widget iconButtonSmallBloc(String text, Function function, IconData iconData,
    Color color, InputsBloc bloc) {
  return StreamBuilder(
    stream: bloc.formValidStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton.icon(
        onPressed: snapshot.hasData ? function : null,
        label: Text(text, style: TextStyle(fontSize: 20)),
        icon: Padding(
            padding: EdgeInsets.only(left: 10, top: 5, right: 5, bottom: 5),
            child: Icon(iconData)),
        style: ElevatedButton.styleFrom(
            primary: color,
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
      );
    },
  );
}

/// Widget que contiene el diseño de una de las cajas de texto de la aplicacion (email)
Widget emailTextBox(InputsBloc bloc) {
  return StreamBuilder(
    stream: bloc.emailStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: Icon(
              Icons.email,
              color: Colors.yellow[700],
            ),
            hintText: "micorreo@tucorreo.com",
            labelText: "Correo Electronico",
            errorText: snapshot.error,
          ),
          onChanged: bloc.changeEmail,
        ),
      );
    },
  );
}

/// Widget que contiene el diseño de una de las cajas de texto de la aplicacion (password)
Widget passwordTextBox(InputsBloc bloc) {
  return StreamBuilder(
    stream: bloc.passwordStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: TextField(
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(
              Icons.vpn_key,
              color: Colors.yellow[700],
            ),
            labelText: "Contraseña",
            // counterText: snapshot.data,
            errorText: snapshot.error,
          ),
          onChanged: bloc.changePassword,
        ),
      );
    },
  );
}

/// Widget que contiene el diseño de una de las cajas de texto de la aplicacion (Cualquiera)
Widget inputTextBox(String hText, String lText, IconData icon,
    TextEditingController controller) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 40.0),
    child: TextField(
      maxLength: 50,
      decoration: InputDecoration(
        icon: Icon(
          icon,
          color: Colors.yellow[700],
        ),
        hintText: hText,
        labelText: lText,
      ),
      controller: controller,
    ),
  );
}

/// Widget que contiene el diseño de una de las cajas de texto con controlador de la aplicacion
class InputTextBoxWController extends StatelessWidget {
  final String hText;
  final String lText;
  final IconData icon;
  final Function(String) update;
  final String value;

  InputTextBoxWController(
      this.hText, this.lText, this.icon, this.update, this.value);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    controller.text = value;
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: TextField(
        controller: controller,
        onChanged: (String a) {
          update(controller.text);
        },
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.yellow[700],
          ),
          hintText: hText,
          labelText: lText,
        ),
      ),
    );
  }
}

/// Widget que contiene el diseño de una de las cajas de texto multilinea con controlador de la aplicacion
Widget inputTextBoxMultiline(String hText, String lText, IconData icon,
    TextEditingController controller) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 40.0),
    child: TextField(
      keyboardType: TextInputType.multiline,
      minLines: 20,
      maxLines: 50,
      decoration: InputDecoration(
        icon: Icon(
          icon,
          color: Colors.yellow[700],
        ),
        hintText: hText,
        labelText: lText,
      ),
      controller: controller,
    ),
  );
}

/// Widget que contiene el diseño de uno de los textos de la aplicacion
Widget textoFinalRojo(String texto) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 30.0),
    decoration: BoxDecoration(
      color: Color.fromRGBO(228, 88, 101, 0.5),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    height: 80.0,
    child: Center(
      child: Text(
        texto,
        style: TextStyle(
          color: Color.fromRGBO(228, 88, 101, 1),
          fontSize: 17.0,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

/// Widget que contiene el diseño de una de las barras superiores (AppBar) de la aplicacion
AppBar crearAppBar(String texto, IconData icono, int constante, Color color,
    {String atras, BuildContext context}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: new IconButton(
      icon: new Icon(Icons.arrow_back_ios, color: kNegro),
      onPressed: () {
        Navigator.pop(context);
        // Navigator.maybePop(context);
        if (context != null && atras != null) {
          Navigator.pushNamed(context, atras);
        }
      },
    ),
    title: Text(
      texto,
      style: TextStyle(
          color: Colors.black, fontSize: 25.0, fontFamily: 'PoppinsRegular'),
    ),
    centerTitle: true,
    iconTheme: IconThemeData(
      color: Colors.black, //change your color here
    ),
  );
}

/// Widget que contiene el diseño de una de las barras superiores (AppBar) de la aplicacion
AppBar crearAppBarAction(String texto, IconData icono, int constante,
    Color color, IconData icon, Function function) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [IconButton(icon: Icon(icon), onPressed: () => function())],
    title: Text(
      texto,
      style: TextStyle(
        color: Colors.black,
        fontSize: 25.0,
      ),
    ),
    centerTitle: true,
    iconTheme: IconThemeData(
      color: Colors.black, //change your color here
    ),
  );
}

/// Widget que contiene el diseño de la barra superior de la seccion [Citas] de la aplicacion
AppBar crearAppBarCitas(
    BuildContext context,
    String rutaBack,
    String texto,
    IconData icono,
    int constante,
    Color color,
    IconData icon,
    Function function) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: new IconButton(
      icon: new Icon(Icons.arrow_back_ios, color: kNegro),
      onPressed: () => Navigator.pop(context),
    ),
    actions: [IconButton(icon: Icon(icon), onPressed: () => function())],
    title: Text(
      texto,
      style: TextStyle(
        color: Colors.black,
        fontSize: 25.0,
      ),
    ),
    centerTitle: true,
    iconTheme: IconThemeData(
      color: Colors.black, //change your color here
    ),
  );
}

/// Widget que contiene el diseño de la barra superior de la seccion [Eventos] de la aplicacion
AppBar crearAppBarEventos(BuildContext context, String titulo, String ruta) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: new IconButton(
      icon: new Icon(Icons.arrow_back_ios, color: kNegro),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, ruta);
      },
    ),
    centerTitle: true,
    title: FittedBox(
      child: Text(
        "$titulo",
        style: TextStyle(
          fontFamily: "PoppinsRegular",
          color: Colors.black,
          fontSize: 25.0,
        ),
      ),
    ),
  );
}

/// Widget que contiene el diseño de una seccion usada en pantallas
Widget secction({String title, String text, bool banco}) {
  return Container(
    width: 270.0,
    height: 46,
    child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Text(
          title,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14.0,
            color: kLetras,
            fontFamily: 'PoppinsRegular',
            decoration: TextDecoration.none,
          ),
        ),
        Column(
          children: <Widget>[
            Text(
              text != null || text == "" ? '\n$text' : '\nPor Definir',
              style: TextStyle(
                fontSize: banco == null ? 14 : 12,
                color: kLetras,
                fontWeight: FontWeight.w300,
                fontFamily: 'PoppinsRegular',
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Container(
                child: Divider(
                  color: Colors.black.withOpacity(0.40),
                  thickness: 1.0,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

/// Widget que contiene el diseño de botones coloreados
Widget colorButton(
    String texto, Function funcion, Color color, Size size, double radius) {
  return Container(
    width: size.width,
    height: size.height * 0.15,
    child: ElevatedButton(
      onPressed: funcion,
      child: Text(
        texto,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontSize: 30.0),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius))),
          elevation: MaterialStateProperty.all<double>(5.0)),
    ),
  );
}

/// Widget que contiene el diseño de la barra superior de foros
Widget crearForosUpper(
    Size size, String text, IconData icono, double heigh, Color color) {
  return Container(
    //height: size.height,
    width: size.width,
    child: Stack(
      children: <Widget>[
        CustomPaint(
          painter: CustomShapeBorder(size, color),
          child: Container(
            width: size.width,
            height: size.height * 0.15,
          ),
        ),
        Container(
          width: size.width,
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: size.height * heigh),
                Icon(
                  icono,
                  size: 50,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          color: Colors.transparent,
        ),
        SizedBox(height: 20.0),
      ],
    ),
  );
}

/// Widget que contiene el diseño de la barra superior sin icono de foros
Widget crearForosUpperNoIcon(Size size, String text, Color color) {
  return Container(
    height: size.height,
    width: size.width,
    child: Stack(
      children: <Widget>[
        CustomPaint(
          painter: CustomShapeBorder(size, color),
          child: Container(
            width: size.width,
            height: size.height * 0.15,
          ),
        ),
        Container(
          width: size.width,
          height: size.height,
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: size.height * 0.10),
                Text(
                  text,
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          color: Colors.transparent,
        ),
      ],
    ),
  );
}

/// Widget que contiene el diseño de la barra de busqueda
Widget searchBar(BuildContext context, Size size, String text,
    List<String> names, List<dynamic> elements, String ruta) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: size.height * 0.15),
          height: 53.33,
          width: size.width - 120.0,
          decoration: BoxDecoration(
            color: kBlanco,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 7.0,
                  color: Colors.grey.withOpacity(0.5)),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: DataSearch(
                      names: names,
                      elements: elements,
                      route: ruta,
                    ),
                  );
                },
                child: Icon(
                  Icons.search_outlined,
                  color: kMoradoClarito,
                  size: 25.0,
                ),
              ),
              Container(
                width: 200,
                child: GestureDetector(
                  onTap: () {
                    showSearch(
                      context: context,
                      delegate: DataSearch(
                        names: names,
                        elements: elements,
                        route: ruta,
                      ),
                    );
                  },
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 15.0,
                        color: kAzulOscuro,
                        fontFamily: 'PoppinsSemiBold'),
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

///Clase que tiene las funciones necesarias para hacer que la barra de busqueda funcione
class DataSearch extends SearchDelegate<String> {
  List<String> names;
  List<dynamic> elements;
  String route;
  DataSearch({
    this.names,
    this.elements,
    this.route,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          names = null;
          query = null;
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = names
        .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          if (route == 'DetalleInformacion') {
            Navigator.pushNamed(
              context,
              route,
              arguments: elements.firstWhere(
                  (element) => element.nombre == suggestionList[index]),
            );
          } else {
            Navigator.pushNamed(
              context,
              route,
              arguments: elements.firstWhere(
                  (element) => element.titulo == suggestionList[index]),
            );
          }
        },
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey),
                ),
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}

class Espacio extends StatelessWidget {
  const Espacio({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(),
          )
        ],
      ),
    );
  }
}

///Widget que contiene el disñeo de un dialogo de alerta usado en la aplicacion
/// Ej: "Datos actualizados correctamente"
showAlertDialog(BuildContext context, String text,
    {String titulo, String ruta}) {
  String title = titulo ?? "Error";
  Widget okButton = FloatingActionButton(
    child: Text("OK"),
    backgroundColor: kMostaza,
    onPressed: () {
      Navigator.of(context).pop();
      if (ruta != null) {
        Navigator.pushNamed(context, ruta);
      }
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
    title: Text(title),
    content: Text(text),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

/// Widget que contiene el dialogo de confirmación
/// Ej: "¿Seguro quiere editar este item? --> Si/No"
AlertDialog dialogoConfirmacion(BuildContext context, String rutaSi,
    String titulo, String mensaje, Function funcionSi,
    {dynamic parametro}) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
        side: BorderSide(color: kNegro, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(37.0))),
    backgroundColor: kBlanco,
    content: Container(
      height: 170.0,
      width: 302.0,
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              "$titulo",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold, fontSize: 16, color: kNegro),
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          Center(
            child: Container(
              width: 259.0,
              height: 55.0,
              child: Text(
                "$mensaje",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    color: kNegro, fontSize: 15, fontWeight: FontWeight.w300),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    if (parametro != null) {
                      funcionSi(parametro);
                    } else {
                      funcionSi();
                    }
                    Navigator.pushNamed(context, rutaSi);
                  },
                  child: Container(
                    height: 30,
                    width: 99,
                    decoration: BoxDecoration(
                      border: Border.all(color: kNegro),
                      borderRadius: BorderRadius.all(
                        Radius.circular(22.0),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Si",
                          style: GoogleFonts.montserrat(
                              color: kNegro,
                              fontSize: 14,
                              fontWeight: FontWeight.w300)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 30,
                    width: 99,
                    decoration: BoxDecoration(
                      border: Border.all(color: kNegro),
                      borderRadius: BorderRadius.all(
                        Radius.circular(22.0),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("No",
                          style: GoogleFonts.montserrat(
                              color: kNegro,
                              fontSize: 14,
                              fontWeight: FontWeight.w300)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

/// Widget que contiene el diseño de donde se esta poniendo las imagenes de los usuarios en su perfil
class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

/// Widget que nos pasa las cartas a un listado de cartas
List<Widget> letterToCard(BuildContext context, Size size, List<Carta> cartas,
    String route, bool condition) {
  List<Widget> cards = [];
  cartas.forEach((element) {
    if (element.aprobado == condition) {
      Card card = Card(
        elevation: 5,
        margin: EdgeInsets.only(
          top: 45.0,
          left: size.width * 0.05,
          right: size.width * 0.05,
          bottom: 15.0,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        shadowColor: Colors.black.withOpacity(1.0),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Icon(Icons.mail),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: Text(
                    "${element.titulo[0].toUpperCase()}${element.titulo.substring(1)}",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20, fontFamily: "PoppinSemiBold")),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 20),
                child: Text(
                    (element.cuerpo.length <= 250)
                        ? element.cuerpo
                        : "${element.cuerpo.substring(0, 250)} ...",
                    textAlign: TextAlign.justify,
                    style:
                        TextStyle(fontFamily: "PoppinsRegular", fontSize: 14)),
              )
            ],
          ),
        ),
      );
      InkWell inkWell = InkWell(
        splashColor: kRosado,
        onTap: () {
          Navigator.pushNamed(context, route, arguments: element);
        },
        child: card,
      );
      cards.add(inkWell);
    }
  });
  return cards;
}

/// Widget Dialogo de confirmacion
Widget adviceDialogLetter(
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
