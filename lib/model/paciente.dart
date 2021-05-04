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
  String telefono;
  String nombreContactoEmergencia;
  String telefonoContactoEmergencia;
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
      "birthDate": this.fechaNacimiento.toIso8601String(),
      "phone": this.telefono,
      "emergencyContactName": this.nombreContactoEmergencia,
      "emergencyContactPhone": this.telefonoContactoEmergencia,
      "emergencyContactRelationship": this.relacionContactoEmergencia
    };
  }

  String nombreCompleto() {
    return this.nombre + " " + this.apellido;
  }

  static fromMap(data) {
    DateTime fechaN;
    data["birthDate"] == null
        ? fechaN = null
        : fechaN = DateTime.parse(data["birthDate"]);

    Paciente p = Paciente(
        uid: data["uid"],
        nombre: data["name"],
        apellido: data["lastName"],
        correo: data["email"],
        ciudad: data["city"],
        fechaNacimiento: fechaN,
        telefono: data["phone"],
        nombreContactoEmergencia: data["emergencyContactName"],
        telefonoContactoEmergencia: data["emergencyContactPhone"],
        relacionContactoEmergencia: data["emergencyContactRelationship"]);
    return p;
  }
}
