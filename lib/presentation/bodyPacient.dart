import 'package:flutter/material.dart';
import '../ux/ColumnaDosPaciente.dart';
import '../ux/ColumnasInicioPaciente.dart';
import '../ux/Encabezado.dart';

///Método que retnorna la página principal para el paciente
///
///Crea el saludo y llama métodos para crear los botones de cada sección
class BodyPacient extends StatelessWidget {
  const BodyPacient({
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
                    ColumnasInicioPaciente(
                      size: size,
                      titulo1: "Necesito Ayuda",
                      titulo2: "Información",
                      titulo3: "Cartas",
                      titulo4: "Redes",
                    ),
                    ColumnaDosPaciente(
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

///Método que retorna un [Widget] para crear un espacio
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
