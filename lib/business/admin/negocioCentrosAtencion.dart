import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/model/centro_atencion.dart';

///Agrega [centroAtencion] con sus campos a Firebase
///
///Retorna `false` en caso de no poder realizar la operacion
bool agregarCentroAtencion(CentroAtencion centroAtencion) {
  bool error = false;
  CollectionReference reference =
      FirebaseFirestore.instance.collection('attentionCenters');

  reference.add({
    "city": centroAtencion.ciudad,
    "email": centroAtencion.correo,
    "free": centroAtencion.gratuito,
    "location": centroAtencion.ubicacion,
    "name": centroAtencion.nombre,
    "state": centroAtencion.departamento,
    "telephone": centroAtencion.telefono,
    "hours": centroAtencion.horaAtencion
  }).catchError((value) {
    error = true;
  });
  return !error;
}

///Actualiza [centroAtencion] con sus campos a Firebase
///
///Retorna `false` en caso de no poder realizar la operacion
bool actualizarCentroAtencion(CentroAtencion centroAtencion) {
  bool error = false;

  CollectionReference reference =
      FirebaseFirestore.instance.collection('attentionCenters');

  reference.doc(centroAtencion.id).update({
    "city": centroAtencion.ciudad,
    "email": centroAtencion.correo,
    "free": centroAtencion.gratuito,
    "location": centroAtencion.ubicacion,
    "name": centroAtencion.nombre,
    "state": centroAtencion.departamento,
    "telephone": centroAtencion.telefono,
    "hours": centroAtencion.horaAtencion
  }).catchError((value) {
    error = true;
  });

  return !error;
}

///Elimina [centroAtencion] con sus campos a Firebase
void eliminarCentroAtencion(CentroAtencion centroAtencion) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection('attentionCenters');

  reference.doc(centroAtencion.id).delete();
}
