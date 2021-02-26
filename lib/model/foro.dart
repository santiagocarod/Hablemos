import 'package:hablemos/model/tema.dart';

class Foro {
  String uid;
  String titulo;
  DateTime fecha;

  List<Tema> temas;

  Foro({
    this.uid,
    this.titulo,
    this.temas,
  }) {
    this.fecha = DateTime.now();
  }
}
