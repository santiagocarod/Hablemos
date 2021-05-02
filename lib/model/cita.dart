import 'package:hablemos/model/paciente.dart';
import 'package:hablemos/model/profesional.dart';

class Cita {
  String id;
  Paciente paciente;
  Profesional profesional;
  DateTime dateTime;
  int costo;
  String lugar;
  String especialidad;
  String tipo;
  bool estado;
  String pago;

  Cita(
      {this.id,
      this.paciente,
      this.profesional,
      this.dateTime,
      this.costo,
      this.lugar,
      this.especialidad,
      this.tipo,
      this.estado,
      this.pago});

  static Cita fromMap(data, id) {
    return Cita(
        id: id,
        paciente: Paciente.fromMap(data["pacient"]),
        profesional: Profesional.fromMap(data["professional"]),
        dateTime: data["dateTime"].toDate(),
        costo: data["cost"],
        lugar: data["place"],
        especialidad: data["area"],
        tipo: data["type"],
        estado: data["state"],
        pago: data["payment"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "pacient": this.paciente.toMap(),
      "professional": this.profesional.toMap(),
      "dateTime": this.dateTime,
      "cost": this.costo,
      "place": this.lugar,
      "area": this.especialidad,
      "type": this.tipo,
      "state": this.estado,
      "payment": this.pago
    };
  }
}
