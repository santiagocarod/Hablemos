import 'package:flutter/cupertino.dart';

class Paciente {
  //Unias del profesional
  String uid;
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

  //
  Paciente(
      {this.uid,
      this.nombre,
      this.apellido,
      this.correo,
      this.ciudad,
      this.fechaNacimiento,
      this.telefono,
      this.nombreContactoEmergencia,
      this.telefonoContactoEmergencia,
      this.relacionContactoEmergencia}) {
    this.foto = null;
  }

  toMap() {
    return {
      "uid": this.uid,
      "lastName": this.apellido,
      "name": this.nombre,
      "email": this.correo,
      "city": this.ciudad,
      "birthDate": this.fechaNacimiento,
      "phone": this.telefono,
      "emergencyContact": this.nombreContactoEmergencia,
      "emergencyPhone": this.telefonoContactoEmergencia,
      "emergencyRelation": this.relacionContactoEmergencia
    };
  }

  String nombreCompleto() {
    return this.nombre + " " + this.apellido;
  }

  static fromMap(data) {
    Paciente p = Paciente();
    return p;
  }
}
