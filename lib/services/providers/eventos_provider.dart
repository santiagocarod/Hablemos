import 'package:hablemos/model/actividad.dart';
import 'package:hablemos/model/grupo.dart';
import 'package:hablemos/model/taller.dart';

class EventoProvider {
  static Taller getTaller() {
    String titulo = 'What is Lorem Ipsum?';
    String descripcion =
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.';
    String valor = '5000';
    String ubicacion = 'Calle 6666 # 19 - 83';
    int numeroSes = 3;

    Taller t = new Taller(
      titulo: titulo,
      descripcion: descripcion,
      numeroSesiones: numeroSes,
      ubicacion: ubicacion,
      valor: valor,
    );

    return t;
  }

  static Actividad getActividad() {
    String titulo = 'What is Lorem Ipsum?';
    String descripcion =
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.';
    String valor = '5000';
    String ubicacion = 'virtual';
    String numCuenta = '542-5126-6123';
    String banco = 'Bancolombia';

    Actividad a = new Actividad(
      titulo: titulo,
      descripcion: descripcion,
      ubicacion: ubicacion,
      valor: valor,
      banco: banco,
      numeroCuenta: numCuenta,
    );

    return a;
  }

  static Grupo getGrupo() {
    String titulo = 'What is Lorem Ipsum?';
    String descripcion =
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.';
    String valor = 'Sin costo';
    String ubicacion = 'Carrera 123 # 111-1';

    Grupo g = new Grupo(
      titulo: titulo,
      descripcion: descripcion,
      valor: valor,
      ubicacion: ubicacion,
    );

    return g;
  }
}
