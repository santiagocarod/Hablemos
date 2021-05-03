import 'package:hablemos/model/foro.dart';
import 'package:hablemos/model/tema.dart';
import 'package:hablemos/services/providers/temas_provider.dart';

class ForoProvider {
  static List<Foro> getForo() {
    List<Foro> foros = [];

    List<Tema> temas = TemaProvider.getTema();

    for (int i = 0; i < 15; i++) {
      String titulo = 'Foro # $i';
      String descripcion =
          'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC';
      Foro f = new Foro(titulo: titulo, temas: temas, descripcion: descripcion);
      foros.add(f);
    }

    return foros;
  }
}
