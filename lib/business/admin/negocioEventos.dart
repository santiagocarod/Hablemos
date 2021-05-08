import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/model/actividad.dart';
import 'package:hablemos/model/taller.dart';

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

  print("aaaaaaaaaaaaaa");
  print(taller.titulo);
  print(taller.descripcion);
  print(taller.ubicacion);
  print(taller.id);

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
          }
        })
      : reference.doc(taller.id).update({
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

void eliminarTaller(Taller taller) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("workshops");

  reference.doc(taller.id).delete();
}

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
