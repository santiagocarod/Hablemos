import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/paciente.dart';
import 'package:hablemos/services/auth.dart';

bool agregarCita(Cita cita) {
  final now = DateTime.now();
  final limite = DateTime(
      now.year, now.month, now.day + 3); //LIMITE DE PONER UNA CITA SON 3 DIAS
  bool error = false;
  if (cita.dateTime.compareTo(limite) <= 0) {
    error = true;
  }
  if (cita.profesional == null) {
    error = true;
  }
  AuthService authService = AuthService();

  authService.getCurrentUser().then((currentUser) {
    FirebaseFirestore.instance
        .collection("pacients")
        .doc(currentUser.uid)
        .get()
        .then((value) {
      print(value.data());
      Paciente paciente = Paciente.fromMap(value);
      cita.paciente = paciente;
      if (!error) {
        CollectionReference reference =
            FirebaseFirestore.instance.collection('appoinments');
        reference.add(cita.toMap());
      }
    });
  });

  return error;
}
