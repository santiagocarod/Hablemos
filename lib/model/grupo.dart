import 'package:flutter/cupertino.dart';
import 'package:hablemos/model/banco.dart';

class Grupo {
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
  String numCuenta;

  Grupo(
      {this.uid,
      this.titulo,
      this.valor,
      this.numeroSesiones,
      this.descripcion,
      this.foto,
      this.ubicacion,
      this.banco,
      this.numCuenta,
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
