import 'package:flutter/cupertino.dart';

///Ejercicio que es presentado al Paciente o al Profesional para su realización
///
///Principalmente cuenta con una serie de pasos a realizar.
class Ejercicio {
  String titulo;
  String descripcion;
  List<String> pasos;
  Image imagen;

  Ejercicio({
    this.titulo,
    this.descripcion,
    this.pasos,
  }) {
    this.imagen = null;
  }
}
