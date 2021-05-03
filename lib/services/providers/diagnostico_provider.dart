import 'package:hablemos/model/diagnostico.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiagnosticoProvider {
  // static List<Diagnostico> getTrastorno() {
  //   List<Diagnostico> trastornos = [];

  //   for (int i = 0; i < 5; i++) {
  //     String nombre = 'Trastorno # $i';
  //     String autoayuda =
  //         'Para muchas personas, el ejercicio regular ayuda a crear sentimientos positivos y mejora el estado de ánimo. Dormir lo suficiente de manera regular, llevar una dieta saludable y evitar el alcohol (un depresor) también puede ayudar a reducir los síntomas de la depresión.';
  //     String definicion =
  //         'La depresión es un trastorno mental, que afecta negativamente la manera como se siente, como piensa y como actúa un individuo.';

  //     List<String> sintomas = [
  //       '- Estados de ánimo persistentes de tristeza.',
  //       '- Cambio en el apetito y peso corporal.',
  //       '- Horas prolongadas de sueño.',
  //       '- Agitación o retraso psicomotor.'
  //     ];

  //     List<String> fuentes = [
  //       '- American Psychiatric Association Felix Torres, M.D., MBA, DFAPA ',
  //     ];

  //     Diagnostico t = new Diagnostico(
  //       nombre: nombre,
  //       autoayuda: autoayuda,
  //       definicion: definicion,
  //       fuentes: fuentes,
  //       sintomas: sintomas,
  //     );

  //     trastornos.add(t);
  //     // addDiagnostico(t);
  //   }
  //   return trastornos;
  // }

  static addDiagnostico(Diagnostico diagnostico) {
    CollectionReference diagnostics =
        FirebaseFirestore.instance.collection('diagnostics');

    diagnostics.add({
      "name": diagnostico.nombre,
      "definition": diagnostico.definicion,
      "symptoms": diagnostico.sintomas,
      "selfhelp": diagnostico.autoayuda,
      "reference": diagnostico.fuentes,
    });
  }
}
