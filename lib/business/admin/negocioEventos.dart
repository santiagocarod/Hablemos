import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/business/cloudinary.dart';
import 'package:hablemos/model/actividad.dart';
import 'package:hablemos/model/grupo.dart';
import 'package:hablemos/model/participante.dart';
import 'package:hablemos/model/taller.dart';

///Agrega [taller] a firebase
///
///Retorna `false` en caso de no poder realizar la operacion
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
        }).catchError((value) {
          error = true;
        });
  return !error;
}

///Actualiza [taller] a firebase
///
///Retorna `false` en caso de no poder realizar la operacion
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
        }).catchError((value) {
          error = true;
        });
  return !error;
}

///Agrega [participante] a un [taller]
///
///Lo agrega a su lista de [taller.participantes]
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

///Elimina un [taller] de firebase
///
///Llama a [eliminarPagosTaller()] para eliminar las fotos de los pagos en Cloudinary
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

///Agrega [actividad] a firebase
///
///Retorna `false` en caso de no poder realizar la operacion
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
        }).catchError((value) {
          error = true;
        });
  return !error;
}

///Actualiza [actividad] en firebase
///
///Retorna `false` en caso de no poder realizar la operacion
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
        }).catchError((value) {
          error = true;
        });
  return !error;
}

///Agrega [participante] a una [actividad]
///
///Lo agrega a su lista de [actividad.participantes]
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

///Elimina una [actividad] de firebase
///
///Llama a [eliminarPagosActividad()] para eliminar las fotos de los pagos en Cloudinary
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

///Agrega [grupo] a firebase
///
///Retorna `false` en caso de no poder realizar la operacion
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
        }).catchError((value) {
          error = true;
        });
  return !error;
}

///Actualiza [grupo] a firebase
///
///Retorna `false` en caso de no poder realizar la operacion
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
        }).catchError((value) {
          error = true;
        });
  return !error;
}

///Agrega [participante] a un [grupo]
///
///Lo agrega a su lista de [grupo.participantes]
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

///Elimina un [grupo] de firebase
///
///Llama a [eliminarPagosGrupo()] para eliminar las fotos de los pagos en Cloudinary
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
