import 'package:cloud_firestore/cloud_firestore.dart';
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
        'date': paciente.fechaNacimiento,
        'picture': paciente.foto,
        'phone': paciente.telefono,
        'emergencyContactName': paciente.nombreContactoEmergencia,
        'emergencyContactPhone': paciente.telefonoContactoEmergencia,
        'emergencyContactRelationship': paciente.relacionContactoEmergencia,
      })
      .then((value) => true)
      .catchError((error) => false);
}
