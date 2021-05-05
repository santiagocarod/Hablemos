import 'package:flutter/cupertino.dart';
import 'package:hablemos/model/banco.dart';

class Grupo {
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
  String numCuenta;

  Grupo(
      {this.id,
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
    return Grupo(
        id: id,
        titulo: data["title"],
        valor: data["cost"] ?? null,
        numeroSesiones: data["numSessions"],
        descripcion: data["description"],
        foto: data["photo"] ?? null,
        ubicacion: data["location"],
        banco: data["bank"] == null ? null : Banco.fromMap(data["bank"]),
        fecha: data["date"],
        hora: data["hour"]);
  }
}
