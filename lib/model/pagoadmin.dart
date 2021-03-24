import 'package:hablemos/model/paciente.dart';
import 'package:hablemos/model/profesional.dart';

class Pagoadmin {
  Profesional profesional;
  int pago;

  Map<String, String> listCitasProfesional;

  Pagoadmin({this.profesional, this.pago, this.listCitasProfesional});
}
