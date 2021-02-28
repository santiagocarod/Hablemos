import 'package:hablemos/model/trastorno.dart';

class TrastornoProvider {
  static List<Trastorno> getTrastorno() {
    List<Trastorno> trastornos = [];

    for (int i = 0; i < 5; i++) {
      String nombre = 'Trastorno # $i';
      String autoayuda =
          'Para muchas personas, el ejercicio regular ayuda a crear sentimientos positivos y mejora el estado de ánimo. Dormir lo suficiente de manera regular, llevar una dieta saludable y evitar el alcohol (un depresor) también puede ayudar a reducir los síntomas de la depresión.';
      String definicion =
          'La depresión es un trastorno mental, que afecta negativamente la manera como se siente, como piensa y como actúa un individuo.';

      List<String> sintomas = [
        '- Estados de ánimo persistentes de tristeza.',
        '- Cambio en el apetito y peso corporal.',
        '- Horas prolongadas de sueño.',
        '- Agitación o retraso psicomotor.'
      ];

      List<String> fuentes = [
        '- American Psychiatric Association Felix Torres, M.D., MBA, DFAPA ',
      ];

      Trastorno t = new Trastorno(
        nombre: nombre,
        autoayuda: autoayuda,
        definicion: definicion,
        fuentes: fuentes,
        sintomas: sintomas,
      );

      trastornos.add(t);
    }
    return trastornos;
  }
}
