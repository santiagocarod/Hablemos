import 'package:hablemos/model/tema.dart';

class Foro {
  String titulo;
  DateTime fecha;

  List<Tema> temas;

  Foro({
    this.titulo,
    this.temas,
  }) {
    this.fecha = DateTime.now();
  }
}
