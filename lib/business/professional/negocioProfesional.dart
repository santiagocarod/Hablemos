import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/model/profesional.dart';

Future<bool> editarPaciente(Profesional profesional) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("professionals");

  return reference
      .doc(profesional.uid)
      .update({
        /*'name': profesional.nombre,
        'lastName': profesional.apellido,
        'phone': profesional.celular,
        'email': profesional.correo,
        'specialty': profesional.especialidad,
        'experience': profesional.experiencia,
        'birthDate': profesional.fechaNacimiento,
        'contracts': ,
        'projects': ,
        'bank':,*/
      })
      .then((value) => true)
      .catchError((error) => false);
}
