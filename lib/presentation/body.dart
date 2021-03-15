import 'package:flutter/material.dart';
import '../ux/ColumnaDos.dart';
import '../ux/ColumnasInicio.dart';
import '../ux/Encabezado.dart';
import 'package:hablemos/ux/atoms.dart';

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
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/pantallaInicio.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: <Widget>[
                EncabezadoHablemos(
                  size: size,
                  text1: '$username',
                ),
                Espacio(size: size),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
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
                      titulo3: "¿Qué hay \n pa' hacer?",
                      titulo4: "Mi Cuenta",
                    ),
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
