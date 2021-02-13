import 'package:flutter/material.dart';
import '../ux/ColumnaDos.dart';
import '../ux/ColumnasInicio.dart';
import '../ux/Encabezado.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
    this.username,
    @required this.size,
  }) : super(key: key);

  final Size size;
  final String username;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        children: <Widget>[
          Image(
            height: size.height + 70,
            width: size.width,
            image: AssetImage("imagenes/pantallaInicio.png"),
            fit: BoxFit.cover,
          ),
          Container(
            height: size.height + 70,
            child: Column(
              children: <Widget>[
                EncabezadoHablemos(
                  size: size,
                  text1: '$username',
                ),
                Espacio(size: size),
                Row(
                  children: <Widget>[
                    Espacio(
                      size: size * 0.4,
                    ),
                    ColumnasInicio(
                      size: size,
                      titulo1: "Necesito Ayuda",
                      titulo2: "Información",
                      titulo3: "Cartas",
                      titulo4: "Redes",
                    ),
                    ColumnaDos(
                      size: size,
                      titulo1: "Citas",
                      titulo2: "Quiero un Momento",
                      titulo3: "Que hay \n pa hacer",
                      titulo4: "Mi Cuenta",
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
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
      width: size.width * 0.2,
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
