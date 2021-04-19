import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/model/centro_atencion.dart';

class CentroAtencionProvider {
  static addCentroAtencion(CentroAtencion centroAtencion) {
    CollectionReference attentionCenters =
        FirebaseFirestore.instance.collection('attentionCenters');
    // static List<CentroAtencion> getCentros() {
    //   List<CentroAtencion> centros = [];
    //   for (int i = 0; i < 10; i++) {
    //     String nombre = 'What is Lorem Ipsum?$i';
    //     String ciudad = 'Bogotá';
    //     String departamento = 'Cundinamarca';
    //     String correo = 'asdhfaksdjf@jasdka.com';
    //     String telefono = '333 - 1231233 - 1232345';
    //     String ubicacion = 'Cra. 14 A ##151a-39, Bogotá';
    //     bool gratuito;

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
