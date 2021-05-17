import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/business/cloudinary.dart';
import 'package:hablemos/model/actividad.dart';
import 'package:hablemos/model/grupo.dart';
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
          'photo': taller.foto,
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
          'photo': taller.foto,
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
          'photo': taller.foto,
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
          'photo': taller.foto,
          "bank": null,
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

  if (taller.foto != null) {
    deleteImage(taller.foto);
    eliminarPagosTaller(taller);
  }
  reference.doc(taller.id).delete();
}

void eliminarPagosTaller(Taller taller) {
  if (taller.participantes != null) {
    taller.participantes.forEach((element) {
      deleteImage(element["payment"]);
    });
  }
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
          'photo': actividad.foto,
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
          'photo': actividad.foto,
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
          'photo': actividad.foto,
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
          'photo': actividad.foto,
          "bank": null,
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

  if (actividad.foto != null) {
    deleteImage(actividad.foto);
    eliminarPagosActividad(actividad);
  }
  reference.doc(actividad.id).delete();
}

void eliminarPagosActividad(Actividad actividad) {
  if (actividad.participantes != null) {
    actividad.participantes.forEach((element) {
      deleteImage(element["payment"]);
    });
  }
}

//GRUPOS
bool agregarGrupo(Grupo grupo) {
  bool error = false;
  CollectionReference reference =
      FirebaseFirestore.instance.collection('groups');

  grupo.banco != null
      ? reference.add({
          "title": grupo.titulo,
          "description": grupo.descripcion,
          "numSessions": grupo.numeroSesiones,
          "location": grupo.ubicacion,
          "cost": grupo.valor,
          'date': grupo.fecha,
          'hour': grupo.hora,
          'photo': grupo.foto,
          "bank": {
            "bank": grupo.banco.banco,
            "type": grupo.banco.tipoCuenta,
            "numAccount": grupo.banco.numCuenta
          }
        })
      : reference.add({
          "title": grupo.titulo,
          "description": grupo.descripcion,
          "numSessions": grupo.numeroSesiones,
          "location": grupo.ubicacion,
          "cost": grupo.valor,
          'date': grupo.fecha,
          'hour': grupo.hora,
          'photo': grupo.foto,
        });
  return !error;
}

bool actualizarGrupo(Grupo grupo) {
  bool error = false;
  CollectionReference reference =
      FirebaseFirestore.instance.collection('groups');

  grupo.banco != null
      ? reference.doc(grupo.id).update({
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
          },
          "participants": grupo.participantes,
          'photo': grupo.foto,
        })
      : reference.doc(grupo.id).update({
          "title": grupo.titulo,
          "description": grupo.descripcion,
          "numSessions": grupo.numeroSesiones,
          "location": grupo.ubicacion,
          "cost": grupo.valor,
          'date': grupo.fecha,
          'hour': grupo.hora,
          "participants": grupo.participantes,
          'photo': grupo.foto,
          "bank": null,
        });
  return !error;
}

bool agregarParticipanteGrupo(Participante participante, Grupo grupo) {
  bool error = false;
  CollectionReference reference =
      FirebaseFirestore.instance.collection('groups');

  Map<String, String> p = participante.toMap();

  if (grupo.participantes == null) {
    grupo.participantes = [];
  }

  grupo.participantes.add(p);

  reference.doc(grupo.id).update({
    "participants": grupo.participantes,
  });

  return !error;
}

void eliminarGrupo(Grupo grupo) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection('groups');

  if (grupo.foto != null) {
    deleteImage(grupo.foto);
    eliminarPagosGrupo(grupo);
  }
  reference.doc(grupo.id).delete();
}

void eliminarPagosGrupo(Grupo grupo) {
  if (grupo.participantes != null) {
    grupo.participantes.forEach((element) {
      deleteImage(element["payment"]);
    });
  }
}
