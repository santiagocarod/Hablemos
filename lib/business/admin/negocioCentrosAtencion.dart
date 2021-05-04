import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/model/centro_atencion.dart';

bool agregarCentroAtencion(CentroAtencion centroAtencion) {
  bool error = false;

  return !error;
}

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
  });

  return !error;
}
