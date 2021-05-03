import 'package:flutter/cupertino.dart';

import 'banco.dart';

class Taller {
  String uid;
  String titulo;
  String fecha;
  String hora;
  String valor;
  int numeroSesiones;
  String descripcion;
  DecorationImage foto;
  String ubicacion;
  Banco banco;

  Taller(
      {this.uid,
      this.titulo,
      this.valor,
      this.numeroSesiones,
      this.descripcion,
      this.foto,
      this.ubicacion,
      this.banco,
      this.fecha,
      this.hora}) {
    this.fecha = DateTime.now().day.toString() +
        '/' +
        DateTime.now().month.toString() +
        '/' +
        DateTime.now().year.toString();
    this.hora =
        DateTime.now().hour.toString() + ':' + DateTime.now().minute.toString();
  }
}
