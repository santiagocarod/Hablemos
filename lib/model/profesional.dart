import 'package:flutter/cupertino.dart';

import 'banco.dart';

class Profesional {
  //Unias del profesional
  String uid;
  String nombre;
  String apellido;
  DateTime fechaNacimiento;
  String especialidad;
  String experiencia;
  List<String> convenios;
  List<String> proyectos;
  String descripcion;
  Image foto;
  Banco banco;
  String celular;
  String correo;

  //
  Profesional(
      {this.uid,
      this.nombre,
      this.apellido,
      this.fechaNacimiento,
      this.especialidad,
      this.experiencia,
      this.convenios,
      this.proyectos,
      this.banco,
      this.celular,
      this.correo}) {
    this.foto = null;
    this.descripcion = 'Aqui va la descripción';
  }

  toMap() {
    return {
      "name": this.nombre,
      "lastName": this.apellido,
      "birthDay": this.fechaNacimiento,
      "specialty": this.especialidad,
      "experience": this.experiencia,
      "contracts": this.convenios,
      "projects": this.proyectos,
      "bank": this.banco.toMap(),
      "phone": this.celular,
      "email": this.correo
    };
  }

  static Profesional fromMap(data, uid) {
    Profesional p = Profesional(
        uid: uid,
        nombre: data["name"],
        apellido: data["lastName"],
        banco: Banco.fromMap(data["bank"]),
        fechaNacimiento: data["birthDay"],
        especialidad: data["specialty"],
        experiencia: data["experience"],
        convenios: List<String>.from(data["contracts"]),
        proyectos: List<String>.from(["projects"]),
        celular: data["phone"],
        correo: data["email"]);

    return p;
  }

  String nombreCompleto() {
    return this.nombre + " " + this.apellido;
  }
}
