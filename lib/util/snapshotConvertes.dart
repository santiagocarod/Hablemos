import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hablemos/model/carta.dart';
import 'package:hablemos/model/centro_atencion.dart';

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

List<CentroAtencion> centrosMapToList(AsyncSnapshot<QuerySnapshot> snapshot) {
  List<CentroAtencion> centros = [];
  snapshot.data.docs.forEach((element) {
    dynamic data = element.data();
    CentroAtencion c = CentroAtencion(
        uid: element.id,
        ciudad: data["city"],
        correo: data['email'],
        departamento: data['state'],
        gratuito: data['free'],
        nombre: data['name'],
        telefono: data['telephone'],
        ubicacion: data['location']);

    centros.add(c);
  });
  return centros;
}
