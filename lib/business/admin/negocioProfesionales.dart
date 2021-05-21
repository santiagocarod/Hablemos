import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/business/cloudinary.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/profesional.dart';

///Agregar un [profesional] a la coleccion de profesionales
///
///Retorna `false` en caso de no poder realizar la operacion
Future<bool> agregarProfesional(Profesional profesional, String value) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("professionals");

  return reference
      .doc(value)
      .set({
        'name': profesional.nombre,
        'lastName': profesional.apellido,
        'phone': profesional.celular,
        'email': profesional.correo,
        'speciality': profesional.especialidad,
        'experience': profesional.experiencia,
        'birthDate': profesional.fechaNacimiento,
        'contracts': profesional.convenios,
        'projects': profesional.proyectos,
        'bank': profesional.banco.toMap(),
        'city': profesional.ciudad,
        'description': profesional.descripcion,
        'uid': value,
      })
      .then((value) => true)
      .catchError((error) => false);
}

///Elimina un [profesional] de la coleccion de firebase
///
///También llama a la funcion [deleteImage()] para eliminar la foto de perfil
Future<bool> eliminarProfesional(Profesional profesional) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("professionals");

  if (profesional.foto != null) {
    deleteImage(profesional.foto);
  }
  return reference
      .doc(profesional.uid)
      .delete()
      .then((value) => true)
      .catchError((error) => false);
}

///Elimina un [profesional] de la coleccion de usuario
void eliminarUsuario(Profesional profesional) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("users");

  reference.doc(profesional.uid).delete();
}

///Actualiza un [profesional] en la colección de usuario
void actualizarUsuario(Profesional profesional) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("users");

  reference.doc(profesional.uid).update({
    "name": profesional.nombre,
  });
}

///Actualizar [profesional] en la colección de profesionales
///
///Retorna `false` en caso de no poder realizar la operacion
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
        'speciality': profesional.especialidad,
        'experience': profesional.experiencia,
        'birthDate': profesional.fechaNacimiento,
        'contracts': profesional.convenios,
        'projects': profesional.proyectos,
        'bank': profesional.banco.toMap(),
        'city': profesional.ciudad,
        'description': profesional.descripcion,
      })
      .then((value) => true)
      .catchError((error) => false);
}

///Cambiar el [profesional] de una [cita] especifica
void actualizarProfesionalCita(Profesional profesional, Cita cita) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("appoinments");
  reference.doc(cita.id).update({"professional": profesional.toMap()});
}
