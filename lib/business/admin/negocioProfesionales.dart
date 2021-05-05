import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/profesional.dart';

Future<bool> agregarCarta(Profesional profesional) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("professionals");

  Map prof = profesional.toMap();
  return reference.add(prof).then((value) => true).catchError((error) => false);
}

Future<bool> eliminarProfesional(Profesional profesional) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("professionals");

  return reference
      .doc(profesional.uid)
      .delete()
      .then((value) => true)
      .catchError((error) => false);
}

void eliminarUsuario(Profesional profesional) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("users");

  reference.doc(profesional.uid).delete();
}

Future<bool> editarProfesional(Profesional profesional) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("professionals");

  return reference
      .doc(profesional.uid)
      .update({
        'name': profesional.nombre,
        'lastName': profesional.apellido,
        'phone': profesional.celular,
        'email': profesional.correo,
        'specialty': profesional.especialidad,
        'experience': profesional.experiencia,
        'birthDate': profesional.fechaNacimiento,
        'contracts': profesional.convenios,
        'projects': profesional.proyectos,
        'bank': profesional.banco,
      })
      .then((value) => true)
      .catchError((error) => false);
}

void actualizarProfesionalCita(Profesional profesional, Cita cita) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("appoinments");
  reference.doc(cita.id).update({"pacient": profesional.toMap()});
}
