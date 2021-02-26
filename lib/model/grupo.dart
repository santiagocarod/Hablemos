import 'package:flutter/cupertino.dart';

class Grupo {
  String titulo;
  String fecha;
  String hora;
  String valor;
  int numeroSesiones;
  String descripcion;
  Image foto;
  String ubicacion;
  String banco;
  String numCuenta;

  Grupo({
    this.titulo,
    this.valor,
    this.numeroSesiones,
    this.descripcion,
    //this.foto,
    this.ubicacion,
    this.banco,
    this.numCuenta,
  }) {
    this.fecha = DateTime.now().day.toString() +
        '/' +
        DateTime.now().month.toString() +
        '/' +
        DateTime.now().year.toString();
    this.hora =
        DateTime.now().hour.toString() + ':' + DateTime.now().minute.toString();
  }
}
