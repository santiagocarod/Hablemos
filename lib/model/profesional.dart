import 'package:flutter/cupertino.dart';

import 'cita.dart';

class Profesional {
  //Unias del profesional
  String nombre;
  String apellido;
  DateTime fechaNacimiento;
  String especialidades;
  String experiencia;
  List<String> convenios;
  Map<String, String> redes;
  List<String> proyectos;
  String descripcion;
  Image foto;
  int numeroCuenta;
  int celular;

  //Externas
  List<Cita> citas;

  //
  Profesional(
      {this.nombre,
      this.apellido,
      this.fechaNacimiento,
      this.especialidades,
      this.experiencia,
      this.convenios,
      this.redes,
      this.proyectos,
      this.citas,
      this.numeroCuenta,
      this.celular}) {
    this.foto = null;
    this.descripcion = '';
  }
}
