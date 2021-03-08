import 'package:hablemos/model/ejercicio.dart';

class ExerciseProvider {
  static List<Ejercicio> getMindfulnes() {
    List<Ejercicio> lista = [];

    for (int i = 0; i < 5; i++) {
      String titulo = 'Ejercicio Mindfulnes $i';
      String descripcion =
          'Segundo: Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s.';
      List<String> pasos = [
        '1.Paso 1: Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
        'Paso 2: Etc etc',
        'Paso 3: Etc etc',
      ];
      Ejercicio ej =
          new Ejercicio(titulo: titulo, descripcion: descripcion, pasos: pasos);
      lista.add(ej);
    }

    return lista;
  }

  static List<Ejercicio> getMeditation() {
    List<Ejercicio> lista = [];

    for (int i = 0; i < 5; i++) {
      String titulo = 'Ejercicio Meditación $i';
      String descripcion =
          'Segundo: Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s.';
      List<String> pasos = [
        '1.Paso 1: Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
        'Paso 2: Etc etc',
        'Paso 3: Etc etc',
      ];
      Ejercicio ej =
          new Ejercicio(titulo: titulo, descripcion: descripcion, pasos: pasos);
      lista.add(ej);
    }

    return lista;
  }
}
