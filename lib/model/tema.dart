import 'package:hablemos/model/respuesta.dart';
import 'package:hablemos/services/providers/profesionales_provider.dart';

class Tema {
  String uidPublicador;
  String nombrePublicador;
  DateTime fecha;
  String cuerpo;

  List<Respuesta> respuestas;

  Tema({this.cuerpo, this.respuestas}) {
    this.uidPublicador = ProfesionalesProvider.getProfesional().uid;
    this.nombrePublicador = ProfesionalesProvider.getProfesional().nombre +
        " " +
        ProfesionalesProvider.getProfesional().apellido;
    this.fecha = DateTime.now();
  }
}
