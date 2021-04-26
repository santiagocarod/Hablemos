import 'package:hablemos/model/pagoadmin.dart';

class PagoAdminProvider {
  static Pagoadmin getPagoadmin() {
    /*Profesional profesional = ProfesionalesProvider.getProfesional();
    Paciente paciente = PacientesProvider.getPaciente();

    Map<String, String> listCitasProfesional;
    int pago = 0;

    for (int i = 0; i < 5; i++) {
      listCitasProfesional["${paciente.nombre}i"] =
          "${paciente.citas[0].dateTime.toString()}+i";
      pago = pago + 5000;
    }

    Pagoadmin pagoadmin;

    pagoadmin = new Pagoadmin(
      profesional: profesional,
      listCitasProfesional: listCitasProfesional,
      pago: pago,
    );

    return pagoadmin;*/
    return Pagoadmin();
  }
}
