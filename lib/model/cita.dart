import 'package:hablemos/model/paciente.dart';
import 'package:hablemos/model/profesional.dart';

class Cita {
  Paciente paciente;
  Profesional profesional;
  DateTime dateTime;
  int costo;
  String lugar;
  String especialidad;
  String tipo;
  bool estado;

  Cita(
      {this.paciente,
      this.profesional,
      this.dateTime,
      this.costo,
      this.lugar,
      this.especialidad,
      this.tipo,
      this.estado});
}
