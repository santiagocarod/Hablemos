import 'package:flutter/cupertino.dart';

import 'banco.dart';

class Taller {
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
  List<dynamic> participantes;

  Taller({
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
    this.participantes,
  });

  toMap() {
    return {
      "title": titulo,
      "cost": valor,
      "numSessions": numeroSesiones,
      "description": descripcion,
      "photo": foto,
      "location": ubicacion,
      "bank": banco,
      "date": fecha,
      "hour": hora,
      "participants": participantes,
    };
  }

  static fromMap(data, id) {
    return Taller(
      id: id,
      titulo: data["title"],
      valor: data["cost"],
      numeroSesiones: data["numSessions"],
      descripcion: data["description"],
      foto: data["photo"] ?? null,
      ubicacion: data["location"],
      banco: data["bank"] == null ? null : Banco.fromMap(data["bank"]),
      fecha: data["date"],
      hora: data["hour"],
      participantes:
          data["participants"] == null ? null : data["participants"].toList(),
    );
  }
}
