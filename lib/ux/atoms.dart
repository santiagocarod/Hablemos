import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/inh_widget.dart';
import 'package:hablemos/model/foro.dart';
import 'package:hablemos/ux/shape_appbar_border.dart';

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
  );
}

Widget crearForosUpper(Size size) {
  return Container(
    height: size.height,
    width: size.width,
    child: Stack(
      children: <Widget>[
        CustomPaint(
          painter: CustomShapeBorder(size),
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
                SizedBox(height: size.height * 0.13),
                Icon(
                  Icons.forum,
                  size: 50,
                ),
                Text(
                  'Foros',
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

Widget boxesListForo(
    BuildContext context, Size size, List<Foro> listadoForos, int numero) {
  return Expanded(
    child: ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
          height: 200,
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '${listadoForos[numero + index].titulo}',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${listadoForos[numero + index].descripcion}',
                    style: TextStyle(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(30.0),
                bottomEnd: Radius.circular(30.0),
                topStart: Radius.circular(30.0),
                topEnd: Radius.circular(30.0),
              ),
              color: listColoresForo[index % listColoresForo.length],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                  offset: Offset(0.0, 2.0),
                )
              ],
            ),
          ),
        );
      },
    ),
  );
}
