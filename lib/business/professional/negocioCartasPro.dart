import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/model/carta.dart';

///Cuando el profesional revisa una [carta] y la acepta su estado pasa a `true`
///
///Retorna `false` en caso de no poder realizar la operacion
Future<bool> aceptarCarta(Carta carta) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("letters");

  return reference
      .doc(carta.id)
      .update({"approved": true})
      .then((value) => true)
      .catchError((error) => false);
}

///Cuando el profesional lo considera adecuado elimina la [carta]
///
///Retorna `false` en caso de no poder realizar la operacion
Future<bool> eliminarCarta(Carta carta) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("letters");

  return reference
      .doc(carta.id)
      .delete()
      .then((value) => true)
      .catchError((error) => false);
}

///Cuando el profesional lo considera adecuado edita la [carta]
///
///Retorna `false` en caso de no poder realizar la operacion
Future<bool> editarCarta(Carta carta) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("letters");

  return reference
      .doc(carta.id)
      .update({
        "title": carta.titulo,
        "body": carta.cuerpo,
        "approved": carta.aprobado,
      })
      .then((value) => true)
      .catchError((error) => false);
}
