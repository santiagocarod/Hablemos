import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants.dart';
import '../../model/cita.dart';
import '../../model/pagoadmin.dart';

void terminarCita(Cita cita) {
  String uid = cita.profesional.uid;
  FirebaseFirestore.instance
      .collection("payments")
      .doc(uid)
      .get()
      .then((value) {
    Pagoadmin pagoadmin = Pagoadmin.fromMap(value.data());
    pagoadmin.listCitasProfesional.add({
      "fecha": cita.dateTime.toString(),
      "nombre": cita.paciente.nombreCompleto()
    });
    FirebaseFirestore.instance.collection("payments").doc(uid).update({
      "payment": pagoadmin.pago + PORCENTAJE_PAGO,
      "citas": pagoadmin.listCitasProfesional
    });
  });

  FirebaseFirestore.instance.collection("appoinments").doc(cita.id).delete();
  print(cita.id);
}
