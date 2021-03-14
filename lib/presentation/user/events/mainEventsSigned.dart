import 'package:flutter/material.dart';
import 'package:hablemos/ux/atoms.dart';
import '../../../constants.dart';

class EventsMainSigned extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBarEventos(context, "¿Qué hay p'a hacer?", 'inicio'),
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/eventsBackground.png',
            alignment: Alignment.center,
            fit: BoxFit.fill,
            width: size.width,
            height: size.height,
          ),
          SingleChildScrollView(
            child: Container(
                alignment: Alignment.center,
                width: size.width,
                child: Column(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: size.height * 0.2,
                        ),
                        _opciones(context, size, "Talleres", "listarTalleres"),
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        _opciones(
                            context, size, "Actividades", "listarActividades"),
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        _opciones(context, size, "Grupos de Apoyo",
                            "listarGruposApoyo"),
                      ],
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }

  AppBar appBarEvento(
      String texto, IconData icono, int constante, Color color) {
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
            color: kLetras, fontSize: 22.0, fontFamily: 'PoppinsRegular'),
      ),
      centerTitle: true,
      iconTheme: IconThemeData(
        color: kLetras, //change your color here
      ),
    );
  }
}

Widget _opciones(
    BuildContext context, Size size, String titulo, String paginaRedireccion) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, paginaRedireccion);
    },
    child: Container(
      height: 132.0,
      width: 276.0,
      alignment: Alignment.center,
      child: Text(
        titulo,
        style: TextStyle(
            color: kLetras,
            fontSize: 23.0,
            fontFamily: 'PoppinsRegular',
            decoration: TextDecoration.none,
            fontStyle: FontStyle.normal),
      ),
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
    ),
  );
}
