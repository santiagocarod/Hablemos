import 'package:hablemos/model/foro.dart';
import 'package:hablemos/model/tema.dart';
import 'package:hablemos/services/providers/temas_provider.dart';

class ForoProvider {
  static List<Foro> getForo() {
    List<Foro> foros = [];

    List<Tema> temas = TemaProvider.getTema();

    for (int i = 0; i < 5; i++) {
      String titulo = 'Foro # $i';
      Foro f = new Foro(titulo: titulo, temas: temas);
      foros.add(f);
    }

    return foros;
  }
}
