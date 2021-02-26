import 'package:flutter/cupertino.dart';

class Actividad {
  String titulo;
  String fecha;
  String hora;
  String valor;
  int numeroSesiones;
  String descripcion;
  Image foto;
  String ubicacion;
  String numeroCuenta;
  String banco;

  Actividad({
    this.titulo,
    this.valor,
    this.numeroSesiones,
    this.descripcion,
    //this.foto,
    this.ubicacion,
    this.numeroCuenta,
    this.banco,
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
