import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/model/profesional.dart';

class ProfesionalesProvider {
  /*static Profesional getProfesional() {
    Profesional profesional;

    String nombre = 'Juan';
    String apellido = 'Superdoctor';
    DateTime fechaNacimiento = DateTime.now();
    String especialidades =
        'Evaluación y Tratamiento de Trastornos Emocionales.';
    String lsitaExperiencia =
        'Master en prevención y tratamiento de conductas adictivas y en terapia cognitivo conductual.';
    List<String> convenios = ['Colmedica', 'Colsanitas', 'Compensar'];
    List<String> proyectos = ['Proyecto1', 'Proyecto2', 'Proyecto3'];
    Banco banco = Banco(
        banco: "Bancolombia",
        numCuenta: "123-5235-543",
        tipoCuenta: "Corriente");
    String numero = "3164448201";

    profesional = new Profesional(
      nombre: nombre,
      apellido: apellido,
      fechaNacimiento: fechaNacimiento,
      especialidad: especialidades,
      experiencia: lsitaExperiencia,
      convenios: convenios,
      proyectos: proyectos,
      banco: banco,
      celular: numero,
    );

    return profesional;
  }*/

  static void addProfesional(Profesional profesional) {
    CollectionReference profesionales =
        FirebaseFirestore.instance.collection('professionals');

    profesionales.doc(profesional.uid).set({
      "name": profesional.nombre,
      "lastName": profesional.apellido,
      "birthdate": profesional.fechaNacimiento,
      "specialty": profesional.especialidad,
      "experience": profesional.experiencia,
      "phone": profesional.celular,
      "bank": {
        "bank": profesional.banco.banco,
        "type": profesional.banco.tipoCuenta,
        "numAccount": profesional.banco.numCuenta
      },
      "projects": profesional.proyectos,
      "contracts": profesional.convenios,
    });
  }
}
