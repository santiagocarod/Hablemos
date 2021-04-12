import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/model/actividad.dart';
import 'package:hablemos/model/banco.dart';
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
    Banco banco1 = Banco(
        banco: "Davivienda",
        numCuenta: "513-6453-653",
        tipoCuenta: "Corriente");
    int numeroSes1 = 5;
    DecorationImage foto = DecorationImage(
        image: AssetImage('assets/images/workshop.png'), fit: BoxFit.cover);
    String fecha = "22/06/2021";
    String hora = "10:00";

    Taller t = new Taller(
        titulo: titulo,
        descripcion: descripcion,
        numeroSesiones: numeroSes,
        ubicacion: ubicacion,
        valor: valor,
        foto: foto,
        fecha: fecha,
        hora: hora);

    Taller t1 = new Taller(
        titulo: titulo1,
        descripcion: descripcion1,
        numeroSesiones: numeroSes1,
        ubicacion: ubicacion1,
        valor: valor1,
        banco: banco1,
        foto: foto,
        fecha: fecha,
        hora: hora);

    Taller t2 = new Taller(
        titulo: titulo,
        descripcion: descripcion,
        numeroSesiones: numeroSes,
        ubicacion: ubicacion,
        valor: valor,
        foto: foto,
        fecha: fecha,
        hora: hora);

    Taller t3 = new Taller(
        titulo: titulo1,
        descripcion: descripcion1,
        numeroSesiones: numeroSes1,
        ubicacion: ubicacion1,
        valor: valor,
        foto: foto,
        fecha: fecha,
        hora: hora);

    Taller t4 = new Taller(
        titulo: titulo,
        descripcion: descripcion,
        numeroSesiones: numeroSes,
        ubicacion: ubicacion,
        valor: valor,
        foto: foto,
        fecha: fecha,
        hora: hora);

    talleres..add(t)..add(t1)..add(t2)..add(t3)..add(t4);

    return talleres;
  }

  static void addTaller(Taller taller) {
    CollectionReference talleres =
        FirebaseFirestore.instance.collection('workshops');
    taller.banco != null
        ? talleres.add({
            "title": taller.titulo,
            "description": taller.descripcion,
            "numSessions": taller.numeroSesiones,
            "location": taller.ubicacion,
            "cost": taller.valor,
            'date': taller.fecha,
            'hour': taller.hora,
            "bank": {
              "bank": taller.banco.banco,
              "type": taller.banco.tipoCuenta,
              "numAccount": taller.banco.numCuenta
            }
          })
        : talleres.add({
            "title": taller.titulo,
            "description": taller.descripcion,
            "numSessions": taller.numeroSesiones,
            "location": taller.ubicacion,
            "cost": taller.valor,
            'date': taller.fecha,
            'hour': taller.hora,
          });
  }

  static List<Actividad> getActividades() {
    List<Actividad> actividades = [];
    Banco banco = Banco(
        banco: "Bancolombia", numCuenta: "123-4659-542", tipoCuenta: "Ahorros");
    String titulo = 'Tipo Actividad 1';
    String descripcion =
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.';
    String valor = '5000';
    String ubicacion = 'virtual';
    String titulo1 = 'Tipo Actividad 2';
    String descripcion1 =
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.';
    String valor1 = '75.000 COP';
    String ubicacion1 = 'Calle 136 #64c-75';
    String valor2 = 'Sin Costo';
    String titulo2 = 'Tipo Actividad 3';
    DecorationImage foto = DecorationImage(
        image: AssetImage('assets/images/activities.png'), fit: BoxFit.cover);

    Actividad a = new Actividad(
      titulo: titulo,
      descripcion: descripcion,
      ubicacion: ubicacion,
      valor: valor,
      banco: banco,
      foto: foto,
    );

    Actividad a1 = new Actividad(
      titulo: titulo1,
      descripcion: descripcion1,
      ubicacion: ubicacion1,
      valor: valor1,
      banco: banco,
      foto: foto,
    );
    Actividad a2 = new Actividad(
      titulo: titulo2,
      descripcion: descripcion,
      ubicacion: ubicacion,
      valor: valor2,
      foto: foto,
    );
    Actividad a3 = new Actividad(
      titulo: titulo1,
      descripcion: descripcion1,
      ubicacion: ubicacion1,
      valor: valor1,
      banco: banco,
      foto: foto,
    );
    Actividad a4 = new Actividad(
      titulo: titulo,
      descripcion: descripcion,
      ubicacion: ubicacion,
      valor: valor,
      banco: banco,
      foto: foto,
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
    Banco banco2 = Banco(
        banco: "Davivienda",
        numCuenta: "513-6453-653",
        tipoCuenta: "Corriente");
    String numCuenta2 = '550-53216-32213';
    int sesiones2 = 3;
    int sesiones = 10;
    int sesiones1 = 7;
    DecorationImage foto = DecorationImage(
        image: AssetImage('assets/images/supportGroup.png'), fit: BoxFit.cover);

    Grupo g = new Grupo(
      titulo: titulo,
      descripcion: descripcion,
      valor: valor,
      ubicacion: ubicacion,
      numeroSesiones: sesiones,
      foto: foto,
    );

    Grupo g1 = new Grupo(
      titulo: titulo1,
      descripcion: descripcion1,
      valor: valor1,
      ubicacion: ubicacion1,
      numeroSesiones: sesiones1,
      foto: foto,
    );

    Grupo g2 = new Grupo(
      titulo: titulo2,
      descripcion: descripcion2,
      valor: valor2,
      ubicacion: ubicacion2,
      numCuenta: numCuenta2,
      banco: banco2,
      numeroSesiones: sesiones2,
      foto: foto,
    );

    Grupo g3 = new Grupo(
      titulo: titulo1,
      descripcion: descripcion1,
      valor: valor1,
      ubicacion: ubicacion1,
      numeroSesiones: sesiones1,
      foto: foto,
    );

    Grupo g4 = new Grupo(
      titulo: titulo,
      descripcion: descripcion,
      valor: valor,
      ubicacion: ubicacion,
      numeroSesiones: sesiones,
      foto: foto,
    );

    grupos..add(g)..add(g1)..add(g2)..add(g3)..add(g4);

    // addGrupo(g);
    // addGrupo(g1);
    // addGrupo(g2);
    // addGrupo(g3);
    // addGrupo(g4);

    return grupos;
  }

  static addGrupo(Grupo grupo) {
    CollectionReference grupos =
        FirebaseFirestore.instance.collection('groups');

    grupo.banco != null
        ? grupos.add({
            "title": grupo.titulo,
            "description": grupo.descripcion,
            "numSessions": grupo.numeroSesiones,
            "location": grupo.ubicacion,
            "cost": grupo.valor,
            'date': grupo.fecha,
            'hour': grupo.hora,
            "bank": {
              "bank": grupo.banco.banco,
              "type": grupo.banco.tipoCuenta,
              "numAccount": grupo.banco.numCuenta
            }
          })
        : grupos.add({
            "title": grupo.titulo,
            "description": grupo.descripcion,
            "numSessions": grupo.numeroSesiones,
            "location": grupo.ubicacion,
            "cost": grupo.valor,
            'date': grupo.fecha,
            'hour': grupo.hora,
          });
  }
}
