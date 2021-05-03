import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/model/carta.dart';

Future<bool> agregarCarta(Carta carta) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("letters");

  Map map = carta.toMap();
  return reference.add(map).then((value) => true).catchError((error) => false);
}
