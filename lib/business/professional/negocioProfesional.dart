import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/business/cloudinary.dart';
import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/profesional.dart';

///Agrega un [profesional] a la colección de profesionales
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
        'picture': profesional.foto,
      })
      .then((value) => true)
      .catchError((error) => false);
}

///Elimina el perfil del [profesional]
///
///En caso de ser necesario elimina la foto de perfil con [deleteImage()]
///Retorna `false` en caso de no poder realizar la operacion
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

///Elimina el [profesional] de la coleccion de "users"
void eliminarUsuario(Profesional profesional) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("users");

  reference.doc(profesional.uid).delete();
}

///Actualiza el nombre del [profesional] en la coleccion de "users"
///
///Retorna `false` en caso de no poder realizar la operacion
void actualizarUsuario(Profesional profesional) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("users");

  reference.doc(profesional.uid).update({
    "name": profesional.nombre,
  });
}

///Actualiza los datos del [profesional]
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
        'picture': profesional.foto,
      })
      .then((value) => true)
      .catchError((error) => false);
}

///Actualiza el perfil del [profesional] dentro de la [cita.profesional]
void actualizarProfesionalCita(Profesional profesional, Cita cita) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("appoinments");
  reference.doc(cita.id).update({"professional": profesional.toMap()});
}

///Actualiza la imagen de perfil del [profesional] con la url [imagePath]
Future<bool> actualizarPerfilPro(Profesional profesional, String imagePath) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("professionals");

  return reference
      .doc(profesional.uid)
      .update({
        "picture": imagePath,
      })
      .then((value) => true)
      .catchError((error) => false);
}
