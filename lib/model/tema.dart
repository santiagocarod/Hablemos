import 'package:hablemos/model/respuesta.dart';

class Tema {
  String uid;
  String uidPublicador;
  String nombrePublicador;
  DateTime fecha;
  String cuerpo;

  List<Respuesta> respuestas;

  Tema({
    this.uid,
    this.cuerpo,
    this.respuestas,
  }) {
    this.fecha = DateTime.now();
  }
}
