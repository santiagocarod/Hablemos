import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/paciente.dart';
import 'package:hablemos/services/auth.dart';

Future<bool> agregarCita(Cita cita) async {
  final now = DateTime.now();
  final limite = DateTime(
      now.year, now.month, now.day + 2); //LIMITE DE PONER UNA CITA SON 3 DIAS
  bool error = false;
  if (limite.isAfter(cita.dateTime)) {
    error = true;
  }
  if (cita.profesional == null) {
    error = true;
  }
  cita.estado = false;
  AuthService authService = AuthService();

  User user = await authService.getCurrentUser();
  DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
      .collection("pacients")
      .doc(user.uid)
      .get();
  Paciente paciente = Paciente.fromMap(documentSnapshot);
  cita.paciente = paciente;

  if (!error) {
    CollectionReference reference =
        FirebaseFirestore.instance.collection('appoinments');
    Map map = cita.toMap();
    reference.add(map);
  }

  return !error;
}
