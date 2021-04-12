import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/model/centro_atencion.dart';

class CentroAtencionProvider {
  static addCentroAtencion(CentroAtencion centroAtencion) {
    CollectionReference attentionCenters =
        FirebaseFirestore.instance.collection('attentionCenters');

    attentionCenters.add({
      "name": centroAtencion.nombre,
      "city": centroAtencion.ciudad,
      "email": centroAtencion.correo,
      "state": centroAtencion.departamento,
      "telephone": centroAtencion.telefono,
      "location": centroAtencion.ubicacion,
      "free": centroAtencion.gratuito
    });
  }
}
