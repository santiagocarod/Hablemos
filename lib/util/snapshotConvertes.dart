import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hablemos/model/actividad.dart';
import 'package:hablemos/model/administrador.dart';
import 'package:hablemos/model/banco.dart';
import 'package:hablemos/model/carta.dart';
import 'package:hablemos/model/centro_atencion.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/paciente.dart';
import 'package:hablemos/model/pagoadmin.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/model/diagnostico.dart';
import 'package:hablemos/model/grupo.dart';
import 'package:hablemos/model/taller.dart';

List<Carta> cartaMapToList(AsyncSnapshot<QuerySnapshot> snapshot) {
  List<Carta> cartas = [];
  snapshot.data.docs.forEach((element) {
    dynamic data = element.data();
    Carta c = Carta(
        uid: element.id,
        aprobado: data['approved'],
        cuerpo: data['body'],
        titulo: data['title']);
    cartas.add(c);
  });
  return cartas;
}

List<CentroAtencion> centrosMapToList(AsyncSnapshot<QuerySnapshot> snapshot) {
  List<CentroAtencion> centros = [];
  snapshot.data.docs.forEach((element) {
    dynamic data = element.data();
    CentroAtencion c = CentroAtencion(
        uid: element.id,
        ciudad: data["city"],
        correo: data['email'],
        departamento: data['state'],
        gratuito: data['free'],
        nombre: data['name'],
        telefono: data['telephone'],
        ubicacion: data['location']);

    centros.add(c);
  });
  return centros;
}

List<Cita> citaMapToList(AsyncSnapshot<QuerySnapshot> snapshot) {
  List<Cita> citas = [];
  snapshot.data.docs.forEach((element) {
    dynamic data = element.data();
    Cita c = Cita.fromMap(data, element.id);
    citas.add(c);
  });

  return citas;
}

List<Taller> tallerMapToList(AsyncSnapshot<QuerySnapshot> snapshot) {
  List<Taller> talleres = [];
  snapshot.data.docs.forEach((element) {
    dynamic data = element.data();

    Taller t = Taller(
        descripcion: data["description"],
        fecha: data["date"],
        hora: data["hour"],
        numeroSesiones: data["numSessions"],
        ubicacion: data["location"],
        titulo: data["title"],
        uid: element.id,
        valor: data["cost"],
        foto: DecorationImage(
            image: AssetImage('assets/images/workshop.png'),
            fit: BoxFit.cover));
    dynamic value;
    data['bank'] == null
        ? value = null
        : value = Banco(
            banco: data["bank"]["bank"],
            numCuenta: data["bank"]["numAccount"],
            tipoCuenta: data["bank"]["type"]);
    t.banco = value;
    talleres.add(t);
  });
  return talleres;
}

List<Profesional> profesionalMapToList(AsyncSnapshot<QuerySnapshot> snapshot) {
  List<Profesional> profesionales = [];
  snapshot.data.docs.forEach((element) {
    dynamic data = element.data();
    Profesional p = Profesional.fromMap(data);
    profesionales.add(p);
  });
  return profesionales;
}

List<Paciente> pacienteMapToList(AsyncSnapshot<QuerySnapshot> snapshot) {
  List<Paciente> pacientes = [];
  snapshot.data.docs.forEach((element) {
    dynamic data = element.data();
    Paciente p = Paciente.fromMap(data);
    pacientes.add(p);
  });
  return pacientes;
}

List<Grupo> grupoMapToList(AsyncSnapshot<QuerySnapshot> snapshot) {
  List<Grupo> grupos = [];
  snapshot.data.docs.forEach((element) {
    dynamic data = element.data();

    Grupo g = Grupo(
        descripcion: data["description"],
        fecha: data["date"],
        hora: data["hour"],
        numeroSesiones: data["numSessions"],
        ubicacion: data["location"],
        titulo: data["title"],
        uid: element.id,
        valor: data["cost"],
        foto: DecorationImage(
            image: AssetImage('assets/images/supportGroup.png'),
            fit: BoxFit.cover));
    dynamic value;
    data['bank'] == null
        ? value = null
        : value = Banco(
            banco: data["bank"]["bank"],
            numCuenta: data["bank"]["numAccount"],
            tipoCuenta: data["bank"]["type"]);
    g.banco = value;
    grupos.add(g);
  });
  return grupos;
}

List<Actividad> actividadMapToList(AsyncSnapshot<QuerySnapshot> snapshot) {
  List<Actividad> grupos = [];
  snapshot.data.docs.forEach((element) {
    dynamic data = element.data();

    Actividad a = Actividad(
        descripcion: data["description"],
        fecha: data["date"],
        hora: data["hour"],
        numeroSesiones: data["numSessions"],
        ubicacion: data["location"],
        titulo: data["title"],
        uid: element.id,
        valor: data["cost"],
        foto: DecorationImage(
            image: AssetImage('assets/images/activities.png'),
            fit: BoxFit.cover));
    dynamic value;
    data['bank'] == null
        ? value = null
        : value = Banco(
            banco: data["bank"]["bank"],
            numCuenta: data["bank"]["numAccount"],
            tipoCuenta: data["bank"]["type"]);
    a.banco = value;
    grupos.add(a);
  });
  return grupos;
}

List<Diagnostico> diagnosticoMapToList(AsyncSnapshot<QuerySnapshot> snapshot) {
  List<Diagnostico> diagnosticos = [];
  snapshot.data.docs.forEach((element) {
    dynamic data = element.data();
    List<dynamic> list = data["symptoms"];
    List<String> listaSintomas = list.cast<String>().toList();

    List<dynamic> list2 = data["reference"];
    List<String> listaFuentes = list2.cast<String>().toList();

    Diagnostico diag = Diagnostico(
        nombre: data["name"],
        definicion: data["definition"],
        autoayuda: data["selfhelp"],
        sintomas: listaSintomas,
        fuentes: listaFuentes);
    diagnosticos.add(diag);
  });

  return diagnosticos;
}

List<Administrador> administradorMapToList(
    AsyncSnapshot<QuerySnapshot> snapshot) {
  List<Administrador> administradores = [];
  snapshot.data.docs.forEach((element) {
    dynamic data = element.data();
    Administrador a = Administrador.fromMap(data);
    administradores.add(a);
  });
  return administradores;
}

List<Pagoadmin> paymentMapToList(AsyncSnapshot<QuerySnapshot> snapshot) {
  List<Pagoadmin> pagos = [];
  snapshot.data.docs.forEach((element) {
    dynamic data = element.data();
    List<dynamic> list = data["citas"];

    List<Map<String, dynamic>> listaCitas =
        list.cast<Map<String, dynamic>>().toList();

    Profesional p = new Profesional(
      nombre: data["professional"]["name"],
      apellido: data["professional"]["lastname"],
      uid: data["professional"]["id"],
    );

    int pago = data["payment"];

    Pagoadmin pg = new Pagoadmin(
        pago: pago, profesional: p, listCitasProfesional: listaCitas);
    pagos.add(pg);
  });

  return pagos;
}
