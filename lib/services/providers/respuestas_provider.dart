import 'package:hablemos/model/respuesta.dart';

class RespuestaProvider {
  static List<Respuesta> getRespuesta() {
    List<Respuesta> respuestas = [];

    for (int i = 0; i < 5; i++) {
      String cuerpoResp = 'Respuesta # ' + '$i';
      Respuesta r = new Respuesta(cuerpoRespuesta: cuerpoResp);
      respuestas.add(r);
    }

    return respuestas;
  }
}
