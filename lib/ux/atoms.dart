import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/inh_widget.dart';
import 'package:hablemos/ux/shape_appbar_border.dart';

import '../constants.dart';

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

Widget iconButtonSmall(String text, Function function, IconData iconData,
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
            counterText: snapshot.data,
            errorText: snapshot.error,
          ),
          onChanged: bloc.changePassword,
        ),
      );
    },
  );
}

Widget inputTextBox(String hText, String lText, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 40.0),
    child: TextField(
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

Widget inputTextBoxMultiline(String hText, String lText, IconData icon) {
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
    ),
  );
}

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

AppBar crearAppBar(String texto, IconData icono, int constante, Color color) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      Hero(
        tag: constante,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Icon(icono, color: color),
        ),
      ),
    ],
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

Widget secction({String title, String text}) {
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
            color: Colors.black,
            fontFamily: 'PoppinsRegular',
            decoration: TextDecoration.none,
          ),
        ),
        Column(
          children: <Widget>[
            Text(
              '\n$text',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontFamily: 'PoppinsRegular',
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Container(
                child: Divider(
                  color: Colors.black.withOpacity(0.40),
                  thickness: 3.0,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ); //Boton como los de ejercicios queiro respirar, mindfulness, quiero meditar
}

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

Widget searchBar(
    BuildContext context, Size size, TextEditingController searchController) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: size.height * 0.15),
          height: 66.0,
          width: 317.5,
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
              Icon(
                Icons.search_outlined,
                color: kMoradoClaro,
                size: 25.0,
              ),
              Container(
                width: 200,
                child: TextField(
                  controller: searchController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(border: InputBorder.none),
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: kAzulOscuro,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  searchController.clear();
                },
                child: Icon(
                  Icons.cancel_outlined,
                  color: kMoradoClaro,
                  size: 25.0,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

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
            Navigator.pushNamed(context, route,
                arguments: elements.firstWhere(
                    (element) => element.nombre == suggestionList[index]));
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
