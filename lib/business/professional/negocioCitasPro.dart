import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants.dart';
import '../../model/cita.dart';
import '../../model/pagoadmin.dart';
import '../cloudinary.dart';

///Cuando se complete la [cita] el profesional [cita.profesional] la termina
///
///Agregando la [cita] y el valor [cita.costo] a su sección de pagos
void terminarCita(Cita cita) {
  String uid = cita.profesional.uid;
  if (cita.pago != null && cita.pago != "") {
    deleteImage(cita.pago);
  }
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
}
