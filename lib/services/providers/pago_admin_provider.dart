import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/model/pagoadmin.dart';

class PagoAdminProvider {
  static void addTaller(Pagoadmin pagoadmin) {
    CollectionReference pago =
        FirebaseFirestore.instance.collection('payments');
    pago.add({
      "payment": pagoadmin.pago,
      "professional": {
        "name": pagoadmin.profesional.nombre,
        "lastname": pagoadmin.profesional.apellido,
        "id": pagoadmin.profesional.uid
      },
      "citas": pagoadmin.listCitasProfesional,
    });
  }
}
