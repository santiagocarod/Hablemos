import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hablemos/model/actividad.dart';
import 'package:hablemos/model/administrador.dart';
import 'package:hablemos/model/carta.dart';
import 'package:hablemos/model/centro_atencion.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/diagnostico.dart';
import 'package:hablemos/model/grupo.dart';
import 'package:hablemos/model/paciente.dart';
import 'package:hablemos/model/pagoadmin.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/model/taller.dart';

List<Carta> cartaMapToList(
    AsyncSnapshot<QuerySnapshot> snapshot, bool condition) {
  List<Carta> cartas = [];
  snapshot.data.docs.forEach((element) {
    dynamic data = element.data();
    Carta c = Carta.fromMap(data, element.id);
    if (c.aprobado && condition) {
      cartas.add(c);
    } else if (!c.aprobado && !condition) {
      cartas.add(c);
    }
  });
  return cartas;
}

List<CentroAtencion> centrosMapToList(AsyncSnapshot<QuerySnapshot> snapshot) {
  List<CentroAtencion> centros = [];
  snapshot.data.docs.forEach((element) {
    dynamic data = element.data();
    CentroAtencion c = CentroAtencion.fromMap(data, element.id);

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

    Taller t = Taller.fromMap(data, element.id);
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

    Grupo g = Grupo.fromMap(data, element.id);
    grupos.add(g);
  });
  return grupos;
}

List<Actividad> actividadMapToList(AsyncSnapshot<QuerySnapshot> snapshot) {
  List<Actividad> grupos = [];
  snapshot.data.docs.forEach((element) {
    dynamic data = element.data();

    Actividad a = Actividad.fromMap(data, element.id);
    grupos.add(a);
  });
  return grupos;
}

List<Diagnostico> diagnosticoMapToList(AsyncSnapshot<QuerySnapshot> snapshot) {
  List<Diagnostico> diagnosticos = [];
  snapshot.data.docs.forEach((element) {
    dynamic data = element.data();

    Diagnostico diag = Diagnostico.fromMap(data, element.id);
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
    // List<dynamic> list = data["citas"];

    // List<Map<String, dynamic>> listaCitas =
    //     list.cast<Map<String, dynamic>>().toList();

    // Profesional p = Profesional.fromMap(data);

    // int pago = data["payment"];

    Pagoadmin pg = Pagoadmin.fromMap(data);
    pagos.add(pg);
  });

  return pagos;
}
