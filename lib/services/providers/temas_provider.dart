import 'package:hablemos/model/respuesta.dart';
import 'package:hablemos/model/tema.dart';
import 'package:hablemos/services/providers/respuestas_provider.dart';

class TemaProvider {
  static List<Tema> getTema() {
    List<Tema> temas = [];

    List<Respuesta> respuestas = RespuestaProvider.getRespuesta();

    for (int i = 0; i < 5; i++) {
      String cuerpo = 'Tema # $i';

      Tema t = new Tema(cuerpo: cuerpo, respuestas: respuestas);

      temas.add(t);
    }

    return temas;
  }
}
