import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hablemos/model/banco.dart';
import 'package:hablemos/model/carta.dart';
import 'package:hablemos/model/centro_atencion.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/paciente.dart';
import 'package:hablemos/model/profesional.dart';
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
    Cita c = Cita(
        paciente: Paciente.fromMap(data["paciente"]),
        profesional: Profesional.fromMap(data["profesional"], "uid"),
        dateTime: data["dateTime"].toDate(),
        costo: data["cost"],
        lugar: data["place"],
        especialidad: data["area"],
        tipo: data["type"],
        estado: data["state"]);
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
    Profesional p = Profesional.fromMap(data, element.id);
    profesionales.add(p);
  });
  return profesionales;
}
