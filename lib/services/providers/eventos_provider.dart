import 'package:flutter/material.dart';
import 'package:hablemos/model/actividad.dart';
import 'package:hablemos/model/grupo.dart';
import 'package:hablemos/model/taller.dart';

class EventoProvider {
  static List<Taller> getTalleres() {
    List<Taller> talleres = [];
    String titulo = 'Taller Tipo 1';
    String descripcion =
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.';
    String valor = '5000';
    String ubicacion = 'Calle 6666 # 19 - 83';
    int numeroSes = 3;
    String titulo1 = 'Taller Tipo 2';
    String descripcion1 =
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.';
    String valor1 = '75000';
    String ubicacion1 = 'Virtual';
    int numeroSes1 = 5;
    DecorationImage foto = DecorationImage(
        image: AssetImage('assets/images/workshop.png'), fit: BoxFit.cover);

    Taller t = new Taller(
      titulo: titulo,
      descripcion: descripcion,
      numeroSesiones: numeroSes,
      ubicacion: ubicacion,
      valor: valor,
      foto: foto,
    );

    Taller t1 = new Taller(
      titulo: titulo1,
      descripcion: descripcion1,
      numeroSesiones: numeroSes1,
      ubicacion: ubicacion1,
      valor: valor1,
      foto: foto,
    );

    Taller t2 = new Taller(
      titulo: titulo,
      descripcion: descripcion,
      numeroSesiones: numeroSes,
      ubicacion: ubicacion,
      valor: valor,
      foto: foto,
    );

    Taller t3 = new Taller(
      titulo: titulo1,
      descripcion: descripcion1,
      numeroSesiones: numeroSes1,
      ubicacion: ubicacion1,
      valor: valor,
      foto: foto,
    );

    Taller t4 = new Taller(
      titulo: titulo,
      descripcion: descripcion,
      numeroSesiones: numeroSes,
      ubicacion: ubicacion,
      valor: valor,
      foto: foto,
    );

    talleres..add(t)..add(t1)..add(t2)..add(t3)..add(t4);

    return talleres;
  }

  static List<Actividad> getActividades() {
    List<Actividad> actividades = [];
    String titulo = 'Tipo Actividad 1';
    String descripcion =
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.';
    String valor = '5000';
    String ubicacion = 'virtual';
    String numCuenta = '542-5126-6123';
    String banco = 'Bancolombia';
    String titulo1 = 'Tipo Actividad 2';
    String descripcion1 =
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.';
    String valor1 = '75.000 COP';
    String ubicacion1 = 'Calle 136 #64c-75';
    String numCuenta1 = '542-5126-6123';
    String banco1 = 'Bancolombia';
    DecorationImage foto = DecorationImage(
        image: AssetImage('assets/images/activities.png'), fit: BoxFit.cover);

    Actividad a = new Actividad(
      titulo: titulo,
      descripcion: descripcion,
      ubicacion: ubicacion,
      valor: valor,
      banco: banco,
      foto: foto,
      numeroCuenta: numCuenta,
    );

    Actividad a1 = new Actividad(
      titulo: titulo1,
      descripcion: descripcion1,
      ubicacion: ubicacion1,
      valor: valor1,
      banco: banco1,
      foto: foto,
      numeroCuenta: numCuenta1,
    );
    Actividad a2 = new Actividad(
      titulo: titulo,
      descripcion: descripcion,
      ubicacion: ubicacion,
      valor: valor,
      banco: banco,
      foto: foto,
      numeroCuenta: numCuenta,
    );
    Actividad a3 = new Actividad(
      titulo: titulo1,
      descripcion: descripcion1,
      ubicacion: ubicacion1,
      valor: valor1,
      banco: banco1,
      foto: foto,
      numeroCuenta: numCuenta1,
    );
    Actividad a4 = new Actividad(
      titulo: titulo,
      descripcion: descripcion,
      ubicacion: ubicacion,
      valor: valor,
      banco: banco,
      foto: foto,
      numeroCuenta: numCuenta,
    );

    actividades..add(a)..add(a1)..add(a2)..add(a3)..add(a4);

    return actividades;
  }

  static List<Grupo> getGrupos() {
    List<Grupo> grupos = [];
    String titulo = 'Grupo Apoyo Tipo 1';
    String descripcion =
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.';
    String valor = 'Sin costo';
    String ubicacion = 'Carrera 123 # 111-1';
    String titulo1 = 'Grupo Apoyo Tipo 2';
    String descripcion1 =
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.';
    String valor1 = 'Sin costo';
    String ubicacion1 = 'virtual';
    String titulo2 = 'Grupo Apoyo Tipo 3';
    String descripcion2 =
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.';
    String valor2 = '65000';
    String ubicacion2 = 'virtual';
    DecorationImage foto = DecorationImage(
        image: AssetImage('assets/images/supportGroup.png'), fit: BoxFit.cover);

    Grupo g = new Grupo(
      titulo: titulo,
      descripcion: descripcion,
      valor: valor,
      ubicacion: ubicacion,
      foto: foto,
    );

    Grupo g1 = new Grupo(
      titulo: titulo1,
      descripcion: descripcion1,
      valor: valor1,
      ubicacion: ubicacion1,
      foto: foto,
    );

    Grupo g2 = new Grupo(
      titulo: titulo2,
      descripcion: descripcion2,
      valor: valor2,
      ubicacion: ubicacion2,
      foto: foto,
    );

    Grupo g3 = new Grupo(
      titulo: titulo1,
      descripcion: descripcion1,
      valor: valor1,
      ubicacion: ubicacion1,
      foto: foto,
    );

    Grupo g4 = new Grupo(
      titulo: titulo,
      descripcion: descripcion,
      valor: valor,
      ubicacion: ubicacion,
      foto: foto,
    );

    grupos..add(g)..add(g1)..add(g2)..add(g3)..add(g4);

    return grupos;
  }
}
