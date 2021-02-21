import 'package:hablemos/model/cita.dart';
import 'package:hablemos/model/paciente.dart';
import 'package:hablemos/services/providers/citas_provider.dart';

class PacientesProvider {
  static Paciente getPaciente() {
    List<Cita> citas = CitasProvider.getCitas();

    Paciente paciente;

    String nombre = 'Daniela';
    String apellido = 'Superpaciente';
    DateTime fechaNacimiento = DateTime.now();
    String ciudad = 'Bogota';
    String correo = 'danisuperpaciente@gmail.com';
    int telefono = 3105592912;

    String nombreCE = 'Mark';
    String relacionCE = 'Esposo';
    int telefonoCE = 3010201005;

    paciente = new Paciente(
        nombre: nombre,
        apellido: apellido,
        fechaNacimiento: fechaNacimiento,
        ciudad: ciudad,
        correo: correo,
        telefono: telefono,
        nombreContactoEmergencia: nombreCE,
        relacionContactoEmergencia: relacionCE,
        telefonoContactoEmergencia: telefonoCE,
        citas: citas);

    return paciente;
  }
}
