import 'package:hablemos/model/banco.dart';

/// Evento especifico de la papaya.
///
/// Puede ser pago o gratis.
/// Puede ser virtual o presencial.
/// En el caso de que sea virtual y pago, en la lista de [participantes] se guarda tambien su pago.
class Grupo {
  String id;
  String titulo;
  String fecha;
  String hora;
  String valor;
  int numeroSesiones;
  String descripcion;
  String foto;
  String ubicacion;
  Banco banco;
  String numCuenta;
  List<dynamic> participantes;

  Grupo({
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
      "title": this.titulo,
      "cost": this.valor,
      "numSessions": this.numeroSesiones,
      "description": this.descripcion,
      "photo": this.foto,
      "location": this.ubicacion,
      "bank": this.banco.toMap(),
      "date": this.fecha,
      "hour": this.hora,
      "participants": participantes,
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
      hora: data["hour"],
      participantes:
          data["participants"] == null ? null : data["participants"].toList(),
    );
  }
}
