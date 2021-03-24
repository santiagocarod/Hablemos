import 'package:hablemos/model/centro_atencion.dart';

class CentroAtencionProvider {
  static List<CentroAtencion> getCentros() {
    List<CentroAtencion> centros = [];
    for (int i = 0; i < 10; i++) {
      String nombre = 'What is Lorem Ipsum?$i';
      String ciudad = 'Bogotá';
      String departamento = 'Cundinamarca';
      String correo = 'asdhfaksdjf@jasdka.com';
      String telefono = '333 - 1231233 - 1232345';
      String ubicacion = 'Cra. 14 A ##151a-39, Bogotá';
      bool gratuito;

      if (i % 2 == 0) {
        gratuito = true;
      } else {
        gratuito = false;
      }

      CentroAtencion ca = new CentroAtencion(
        nombre: nombre,
        ciudad: ciudad,
        correo: correo,
        departamento: departamento,
        telefono: telefono,
        ubicacion: ubicacion,
        gratuito: gratuito,
      );
      centros.add(ca);
    }
    return centros;
  }
}
