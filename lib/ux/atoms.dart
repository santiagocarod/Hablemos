import 'package:flutter/material.dart';

Widget iconButton(
    String text, Function function, IconData iconData, Color color) {
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
    return ElevatedButton.icon(
      onPressed: function,
      label: Text(text, style: TextStyle(fontSize: 20)),
      icon: Padding(
          padding: EdgeInsets.only(left: 10, top: 20, right: 20, bottom: 20),
          child: Icon(iconData)),
      style: ElevatedButton.styleFrom(
          primary: color,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    );
  });
}

Widget emailTextBox(TextEditingController controller) {
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: TextField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: Icon(
              Icons.email,
              color: Colors.yellow[700],
            ),
            hintText: "micorreo@tucorreo.com",
            labelText: "Correo Electronico",
          )),
    );
  });
}

Widget passwordTextBox(TextEditingController controller) {
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: TextField(
          controller: controller,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(
              Icons.vpn_key,
              color: Colors.yellow[700],
            ),
            labelText: "Contraseña",
          )),
    );
  });
}
