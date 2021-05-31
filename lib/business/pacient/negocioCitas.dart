import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/paciente.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/services/auth.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import '../cloudinary.dart';

///Agrega una [cita] a la colección de firebase
///
///El limite de agendar una cita son 3 dias de anticipación
///La crea con estado no aceptada, hasta que el profesional no la acepte.
///Le asigna el precio con la constante [COSTO_CITA]
///Asigna el paciente como el usuario que esta en la sesion
Future<bool> agregarCita(Cita cita) async {
  final now = DateTime.now();
  final limite = DateTime(

      ///LIMITE DE PONER UNA CITA SON 3 DIAS
      now.year,
      now.month,
      now.day + 2);
  bool error = false;
  if (limite.isAfter(cita.dateTime)) {
    error = true;
  }
  if (cita.profesional == null) {
    error = true;
  }
  cita.estado = false;
  cita.costo = COSTO_CITA;
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

/// Cancelar una [cita]
///
/// Se debe verificar que la fecha de la [cita] no se encuentre dentro de los próximos 3 dias al dia de `hoy`
/// En caso de que no se cumpla esa condición, se puede eliminar de la colección
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
}

///Actualizar el estado de una [ctia]
///
///Esto lo hace el profesional cuando acepta un pago.
void actualizarEstado(Cita cita) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection('appoinments');
  reference.doc(cita.id).update({"state": true});
}

///En caso de que el [paciente] actualice alguno de los campos de la [cita]
///
///Solo se puede hacer si la cita no esta dentro de los siguientes 3 dias
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
    reference.doc(cita.id).update({
      "type": typeController,
      "professional": profesional.toMap(),
      "dateTime": date
    });
  }
  return !error;
}

///En caso de que el [profesional] actualice alguno de los campos de la [cita]
///
///Solo se puede hacer si la cita no esta dentro de los siguientes 3 dias
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

///Cuando un paciente agrega un pago a la [cita]
///
///[imagePath] es la url a la imagen
Future<bool> actualizarPago(Cita cita, String imagePath) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection('appoinments');
  if (cita.pago != null && cita.pago != "") {
    deleteImage(cita.pago);
  }

  return reference
      .doc(cita.id)
      .update({
        "payment": imagePath,
      })
      .then((value) => true)
      .catchError((error) => false);
}
