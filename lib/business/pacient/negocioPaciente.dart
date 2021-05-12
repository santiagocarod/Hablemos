import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/business/cloudinary.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/paciente.dart';

Future<bool> editarPaciente(Paciente paciente) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("pacients");

  return reference
      .doc(paciente.uid)
      .update({
        'name': paciente.nombre,
        'lastName': paciente.apellido,
        'city': paciente.ciudad,
        'email': paciente.correo,
        'birthDate': paciente.fechaNacimiento,
        'picture': paciente.foto,
        'phone': paciente.telefono,
        'emergencyContactName': paciente.nombreContactoEmergencia,
        'emergencyContactPhone': paciente.telefonoContactoEmergencia,
        'emergencyContactRelationship': paciente.relacionContactoEmergencia,
      })
      .then((value) => true)
      .catchError((error) => false);
}

void actualizarPacienteCita(Paciente paciente, Cita cita) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("appoinments");
  reference.doc(cita.id).update({"pacient": paciente.toMap()});
}

void actualizarUsuario(Paciente paciente) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("users");

  reference.doc(paciente.uid).update({
    "name": paciente.nombre,
  });
}

Future<bool> eliminarPaciente(Paciente paciente) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("pacients");

  if (paciente.foto != "falta foto") {
    deleteImage(paciente.foto);
  }
  return reference
      .doc(paciente.uid)
      .delete()
      .then((value) => true)
      .catchError((error) => false);
}

void eliminarUsuario(Paciente paciente) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("users");

  reference.doc(paciente.uid).delete();
}

Future<bool> actualizarPerfil(Paciente paciente, String imagePath) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("pacients");

  return reference
      .doc(paciente.uid)
      .update({
        "picture": imagePath,
      })
      .then((value) => true)
      .catchError((error) => false);
}
