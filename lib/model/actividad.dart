import 'package:flutter/cupertino.dart';

import 'banco.dart';

class Actividad {
  String id;
  String titulo;
  String fecha;
  String hora;
  String valor;
  int numeroSesiones;
  String descripcion;
  DecorationImage foto;
  String ubicacion;
  Banco banco;

  Actividad({
    this.id,
    this.titulo,
    this.valor,
    this.numeroSesiones,
    this.descripcion,
    this.foto,
    this.ubicacion,
    this.banco,
    this.fecha,
    this.hora,
  }) {
    this.fecha = DateTime.now().day.toString() +
        '/' +
        DateTime.now().month.toString() +
        '/' +
        DateTime.now().year.toString();
    this.hora =
        DateTime.now().hour.toString() + ':' + DateTime.now().minute.toString();
  }

  toMap() {
    return {
      "title": this.titulo,
      "cost": this.valor,
      "numSessions": this.numeroSesiones,
      "description": this.descripcion,
      "photo": this.foto,
      "location": this.ubicacion,
      "bank": this.banco.toMap(),
      "date": this.fecha,
      "hour": this.hora
    };
  }

  static fromMap(data, id) {
    return Actividad(
        id: id,
        titulo: data["title"],
        valor: data["cost"],
        numeroSesiones: data["numSessions"],
        descripcion: data["type"],
        foto: data["photo"],
        ubicacion: data["location"],
        banco: Banco.fromMap(data["bank"]),
        fecha: data["date"],
        hora: data["hour"]);
  }
}
