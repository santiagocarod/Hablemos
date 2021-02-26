import 'package:flutter/cupertino.dart';

class Grupo {
  String titulo;
  String fecha;
  String hora;
  int valor;
  int numeroSesiones;
  String descripcion;
  Image foto;
  String ubicacion;

  Grupo(
    this.titulo,
    this.valor,
    this.numeroSesiones,
    this.descripcion,
    this.foto,
    this.ubicacion,
  ) {
    this.fecha = DateTime.now().day.toString() +
        '/' +
        DateTime.now().month.toString() +
        '/' +
        DateTime.now().year.toString();
    this.hora =
        DateTime.now().hour.toString() + ':' + DateTime.now().minute.toString();
  }
}
