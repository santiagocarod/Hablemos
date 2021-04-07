import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/services/providers/citas_provider.dart';

class ProfesionalesProvider {
  static Profesional getProfesional() {
    List<Cita> citas = CitasProvider.getCitas();

    Profesional profesional;

    String nombre = 'Juan';
    String apellido = 'Superdoctor';
    DateTime fechaNacimiento = DateTime.now();
    String especialidades =
        'Evaluación y Tratamiento de Trastornos Emocionales.';
    String lsitaExperiencia =
        'Master en prevención y tratamiento de conductas adictivas y en terapia cognitivo conductual.';
    List<String> convenios = ['Colmedica', 'Colsanitas', 'Compensar'];
    List<String> redes = [
      'facebook: fb.com/Juan',
      'twitter: @juan_sd',
      'instagram: @juan_sd'
    ];
    List<String> proyectos = ['Proyecto1', 'Proyecto2', 'Proyecto3'];
    int cuenta = 31092938919;
    int numero = 3164448201;
    String correo = 'superdoctor@gmail.com';

    profesional = new Profesional(
      nombre: nombre,
      apellido: apellido,
      fechaNacimiento: fechaNacimiento,
      especialidades: especialidades,
      experiencia: lsitaExperiencia,
      convenios: convenios,
      redes: redes,
      proyectos: proyectos,
      citas: citas,
      numeroCuenta: cuenta,
      celular: numero,
      correo: correo,
    );

    return profesional;
  }
}
