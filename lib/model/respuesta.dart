import 'package:hablemos/services/providers/profesionales_provider.dart';

class Respuesta {
  String uidPublicador;
  String nombrePublicador;
  String cuerpoRespuesta;

  Respuesta({
    this.cuerpoRespuesta,
  }) {
    this.nombrePublicador = ProfesionalesProvider.getProfesional().nombre +
        " " +
        ProfesionalesProvider.getProfesional().apellido;
    this.uidPublicador = ProfesionalesProvider.getProfesional().uid;
  }
}
