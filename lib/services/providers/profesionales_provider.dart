import 'package:hablemos/model/profesional.dart';

class ProfesionalesProvider {
  static Profesional getProfesional() {
    Profesional profesional;

    String nombre = 'Juan';
    String apellido = 'Superdoctor';
    DateTime fechaNacimiento = DateTime.now();
    String especialidades =
        'Evaluación y Tratamiento de Trastornos Emocionales.';
    String lsitaExperiencia =
        'Master en prevención y tratamiento de conductas adictivas y en terapia cognitivo conductual.';
    List<String> convenios = ['Colmedica', 'Colsanitas', 'Compensar'];
    Map<String, String> redes = {
      'facebook': 'fb.com/Juan',
      'twitter': '@juan_sd',
      'instagram': '@juan_sd'
    };
    List<String> proyectos = ['Proyecto1', 'Proyecto2', 'Proyecto3'];
    int cuenta = 31092938919;
    int numero = 3164448201;

    profesional = new Profesional(
      nombre: nombre,
      apellido: apellido,
      fechaNacimiento: fechaNacimiento,
      especialidades: especialidades,
      experiencia: lsitaExperiencia,
      convenios: convenios,
      redes: redes,
      proyectos: proyectos,
      numeroCuenta: cuenta,
      celular: numero,
    );

    return profesional;
  }
}
