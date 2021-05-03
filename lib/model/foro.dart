import 'package:hablemos/model/tema.dart';

class Foro {
  String uid;
  String titulo;
  String descripcion;
  DateTime fecha;

  List<Tema> temas; //TODO: CAmbiar esto a un String con el ID del tema(?)

  Foro({
    this.uid,
    this.titulo,
    this.temas,
    this.descripcion,
  }) {
    this.fecha = DateTime.now();
  }
}
