import 'package:flutter/cupertino.dart';
import 'package:hablemos/model/cita.dart';

class Paciente {
  //Unias del profesional
  String nombre;
  String apellido;
  Image foto;
  String correo;
  String ciudad;
  DateTime fechaNacimiento;
  int telefono;
  String nombreContactoEmergencia;
  int telefonoContactoEmergencia;
  String relacionContactoEmergencia;

  //Externas
  List<Cita> citas;

  //
  Paciente(
      {this.nombre,
      this.apellido,
      this.correo,
      this.ciudad,
      this.fechaNacimiento,
      this.telefono,
      this.nombreContactoEmergencia,
      this.telefonoContactoEmergencia,
      this.relacionContactoEmergencia,
      this.citas}) {
    this.foto = null;
  }
}
