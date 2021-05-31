import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/business/cloudinary.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/paciente.dart';

///Editar un [Paciente]
///
///Retorna `false` en caso de no poder realizar la operacion
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

///Actualiza el [paciente] dentro de una [cita]
void actualizarPacienteCita(Paciente paciente, Cita cita) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("appoinments");
  reference.doc(cita.id).update({"pacient": paciente.toMap()});
}

///Actualiza el nombre de un [paciente] dentro de la coleccion de "users"
void actualizarUsuario(Paciente paciente) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("users");

  reference.doc(paciente.uid).update({
    "name": paciente.nombre,
  });
}

///Elimina un [paciente] dentro de la colección de pacientes
///
///Retorna `false` en caso de no poder realizar la operacion
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

///Elimina el usuario al que corresponde el [paciente]
void eliminarUsuario(Paciente paciente) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("users");

  reference.doc(paciente.uid).delete();
}

///Actualiza la foto de perfil del [paciente] con la ruta de [imagePath]
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
