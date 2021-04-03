import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hablemos/model/carta.dart';

List<Carta> cartaMapToList(AsyncSnapshot<QuerySnapshot> snapshot) {
  List<Carta> cartas = [];
  snapshot.data.docs.forEach((element) {
    dynamic data = element.data();
    Carta c = Carta(
        uid: element.id,
        aprobado: data['approved'],
        cuerpo: data['body'],
        titulo: data['title']);
    cartas.add(c);
  });
  return cartas;
}
