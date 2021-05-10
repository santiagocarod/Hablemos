import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/model/actividad.dart';
import 'package:hablemos/model/participante.dart';
import 'package:hablemos/model/taller.dart';

//TALLERES
bool agregarTaller(Taller taller) {
  bool error = false;
  CollectionReference reference =
      FirebaseFirestore.instance.collection('workshops');

  taller.banco != null
      ? reference.add({
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
      : reference.add({
          "title": taller.titulo,
          "description": taller.descripcion,
          "numSessions": taller.numeroSesiones,
          "location": taller.ubicacion,
          "cost": taller.valor,
          'date': taller.fecha,
          'hour': taller.hora,
        });
  return !error;
}

bool actualizarTaller(Taller taller) {
  bool error = false;
  CollectionReference reference =
      FirebaseFirestore.instance.collection('workshops');

  taller.banco != null
      ? reference.doc(taller.id).update({
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
          },
          "participants": taller.participantes,
        })
      : reference.doc(taller.id).update({
          "title": taller.titulo,
          "description": taller.descripcion,
          "numSessions": taller.numeroSesiones,
          "location": taller.ubicacion,
          "cost": taller.valor,
          'date': taller.fecha,
          'hour': taller.hora,
          "participants": taller.participantes,
        });
  return !error;
}

bool agregarParticipante(Participante participante, Taller taller) {
  bool error = false;

  CollectionReference reference =
      FirebaseFirestore.instance.collection("workshops");

  Map<String, String> p = participante.toMap();

  if (taller.participantes == null) {
    taller.participantes = [];
  }

  taller.participantes.add(p);

  reference.doc(taller.id).update({
    "participants": taller.participantes,
  });

  return !error;
}

void eliminarTaller(Taller taller) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("workshops");

  reference.doc(taller.id).delete();
}

//ACTIVIDADES
bool agregarActividades(Actividad actividad) {
  bool error = false;
  CollectionReference reference =
      FirebaseFirestore.instance.collection('activities');

  actividad.banco != null
      ? reference.add({
          "title": actividad.titulo,
          "description": actividad.descripcion,
          "numSessions": actividad.numeroSesiones,
          "location": actividad.ubicacion,
          "cost": actividad.valor,
          'date': actividad.fecha,
          'hour': actividad.hora,
          "bank": {
            "bank": actividad.banco.banco,
            "type": actividad.banco.tipoCuenta,
            "numAccount": actividad.banco.numCuenta
          }
        })
      : reference.add({
          "title": actividad.titulo,
          "description": actividad.descripcion,
          "numSessions": actividad.numeroSesiones,
          "location": actividad.ubicacion,
          "cost": actividad.valor,
          'date': actividad.fecha,
          'hour': actividad.hora,
        });
  return !error;
}

bool actualizarActividad(Actividad actividad) {
  bool error = false;
  CollectionReference reference =
      FirebaseFirestore.instance.collection('activities');

  actividad.banco != null
      ? reference.doc(actividad.id).update({
          "title": actividad.titulo,
          "description": actividad.descripcion,
          "numSessions": actividad.numeroSesiones,
          "location": actividad.ubicacion,
          "cost": actividad.valor,
          'date': actividad.fecha,
          'hour': actividad.hora,
          "bank": {
            "bank": actividad.banco.banco,
            "type": actividad.banco.tipoCuenta,
            "numAccount": actividad.banco.numCuenta
          },
          "participants": actividad.participantes,
        })
      : reference.doc(actividad.id).update({
          "title": actividad.titulo,
          "description": actividad.descripcion,
          "numSessions": actividad.numeroSesiones,
          "location": actividad.ubicacion,
          "cost": actividad.valor,
          'date': actividad.fecha,
          'hour': actividad.hora,
          "participants": actividad.participantes,
        });
  return !error;
}

bool agregarParticipanteActividad(
    Participante participante, Actividad actividad) {
  bool error = false;
  CollectionReference reference =
      FirebaseFirestore.instance.collection('activities');

  Map<String, String> p = participante.toMap();

  if (actividad.participantes == null) {
    actividad.participantes = [];
  }

  actividad.participantes.add(p);

  reference.doc(actividad.id).update({
    "participants": actividad.participantes,
  });

  return !error;
}

void eliminarActividad(Actividad actividad) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection('activities');

  reference.doc(actividad.id).delete();
}

//GRUPOS
