import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/model/carta.dart';

Future<bool> aceptarCarta(Carta carta) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("letters");

  return reference
      .doc(carta.id)
      .update({"approved": true})
      .then((value) => true)
      .catchError((error) => false);
}

Future<bool> eliminarCarta(Carta carta) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("letters");

  return reference
      .doc(carta.id)
      .delete()
      .then((value) => true)
      .catchError((error) => false);
}

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
