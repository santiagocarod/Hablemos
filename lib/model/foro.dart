import 'package:hablemos/model/tema.dart';

class Foro {
  String uid;
  String titulo;
  String descripcion;
  DateTime fecha;

  List<Tema> temas;

  Foro({
    this.uid,
    this.titulo,
    this.temas,
    this.descripcion,
  }) {
    this.fecha = DateTime.now();
  }
}
