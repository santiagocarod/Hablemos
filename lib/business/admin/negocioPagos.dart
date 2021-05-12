import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/model/pagoadmin.dart';
import 'package:hablemos/model/profesional.dart';

Future<bool> aceptarPago(Pagoadmin pago) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("payments");

  return reference
      .doc(pago.uid)
      .update({
        "payment": 0,
        "citas": [],
      })
      .then((value) => true)
      .catchError((error) => false);
}

Future<bool> crearPago(Profesional profesional) {
  Pagoadmin pago = Pagoadmin(
      uid: profesional.uid,
      pago: 0,
      profesional: profesional,
      listCitasProfesional: []);

  CollectionReference reference =
      FirebaseFirestore.instance.collection('payments');

  Map map = pago.toMap();

  return reference
      .doc(pago.uid)
      .set(map)
      .then((value) => true)
      .catchError((error) => false);
}

Future<bool> actualizarProfesional(Profesional profesional) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("payments");

  return reference
      .doc(profesional.uid)
      .update({"profesional": profesional.toMapPago()})
      .then((value) => true)
      .catchError((error) => false);
}
