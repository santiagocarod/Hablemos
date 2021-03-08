import 'package:flutter/cupertino.dart';

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
