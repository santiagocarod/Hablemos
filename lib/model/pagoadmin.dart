import 'package:hablemos/model/profesional.dart';

class Pagoadmin {
  Profesional profesional;
  int pago;

  List<Map<String, dynamic>> listCitasProfesional;

  Pagoadmin({this.profesional, this.pago, this.listCitasProfesional});
}
