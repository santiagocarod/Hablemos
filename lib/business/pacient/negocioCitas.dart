import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/paciente.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/services/auth.dart';
import 'package:intl/intl.dart';

//TODO: Agregar registro en la parte de pago y eliminarlo

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
  cita.costo = 20000; //TODO:Definir precios
  cita.pago = "";
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

void cancelarCita(Cita cita) {
  final now = DateTime.now();
  final limite = DateTime(now.year, now.month,
      now.day + 2); //LIMITE DE CANCELAR UNA CITA SON 3 DIAS
  bool error = false;
  if (limite.isAfter(cita.dateTime)) {
    error = true;
  }

  if (!error) {
    CollectionReference reference =
        FirebaseFirestore.instance.collection('appoinments');
    reference.doc(cita.id).delete();
  }
  // else {
  //   throw new Exception("No se puede cancelar");
  // }
}

void actualizarEstado(Cita cita) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection('appoinments');
  reference.doc(cita.id).update({"state": true});
}

bool actualizarCitaPaciente(
    Cita cita, Profesional profesional, DateTime date, String typeController) {
  final now = DateTime.now();
  final limite = DateTime(now.year, now.month,
      now.day + 2); //LIMITE DE CANCELAR UNA CITA SON 3 DIAS
  bool error = false;
  if (limite.isAfter(date) && limite.isBefore(date)) {
    error = true;
  }
  if (!error) {
    CollectionReference reference =
        FirebaseFirestore.instance.collection('appoinments');
    reference
        .doc(cita.id)
        .update({"type": typeController, "professional": profesional.toMap()});
  }
  return !error;
}

bool actualizarCitaProfesional(Cita cita, Map data) {
  DateTime date = DateFormat('d/M/yyyy hh:mm a')
      .parse(data["fecha"].text + ' ' + data["hora"].text);
  final now = DateTime.now();
  final limite = DateTime(now.year, now.month,
      now.day + 2); //LIMITE DE CANCELAR UNA CITA SON 3 DIAS
  bool error = false;
  if (limite.isAfter(date) && limite.isBefore(date)) {
    error = true;
  }
  int precio = int.parse(data["precio"].text);
  // String detalles = data["detalles"].text;
  String lugar = data["lugar"].text;
  String especialidad = data["especialidad"].text;
  String tipo = data["tipo"].text;
  String contacto = data["contacto"].text;
  if (precio < 0) {
    error = true;
  }

  if (!error) {
    CollectionReference reference =
        FirebaseFirestore.instance.collection('appoinments');
    reference.doc(cita.id).update({
      "place": lugar,
      "type": tipo,
      "area": especialidad,
      "professional.phone": contacto,
      "cost": precio
    });
  }
  return !error;
}
