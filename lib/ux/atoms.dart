import 'package:flutter/material.dart';
import 'package:hablemos/inh_widget.dart';

Widget iconButton(String text, Function function, IconData iconData,
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
