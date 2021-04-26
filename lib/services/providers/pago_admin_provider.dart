import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/model/pagoadmin.dart';
import 'package:hablemos/model/profesional.dart';

class PagoAdminProvider {
  // static Pagoadmin getPagoadmin() {
  //   Profesional p =
  //       new Profesional(nombre: "Prueba", apellido: "Sip", uid: "12312030");

  //   int pago = 3000;

  //   List<Map<String, String>> lista = [
  //     {
  //       "name": "Paciente1",
  //       "fecha": "11/11/2021",
  //     },
  //     {
  //       "name": "Paciente1",
  //       "fecha": "11/11/2021",
  //     },
  //     {
  //       "name": "Paciente1",
  //       "fecha": "11/11/2021",
  //     }
  //   ];

  //   Pagoadmin pg =
  //       new Pagoadmin(profesional: p, pago: pago, listCitasProfesional: lista);

  //   addTaller(pg);
  //   addTaller(pg);
  //   addTaller(pg);

  //   return pg;
  // }

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
