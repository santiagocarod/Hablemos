import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/model/cita.dart';
<<<<<<< HEAD

/*String _randomString(int length) {
  var rand = new Random();
  var codeUnits = new List.generate(length, (index) {
    return rand.nextInt(33) + 89;
  });

  return new String.fromCharCodes(codeUnits);
}*/
=======
>>>>>>> origin/dev

class CitasProvider {
  /*static List<Cita> getCitas() {
    List<Cita> citas = [];
    for (int i = 0; i < 2; i++) {
      String uid1 = _randomString(10);
      String uid2 = _randomString(10);
      DateTime dateTime = DateTime.now();
      int costo = Random().nextInt(100000);
      String lugar = _randomString(5);
      String especialidad = _randomString(8);
      String tipo = _randomString(3);
      citas.add(new Cita(
          uidPaciente: uid1,
          uidProfesional: uid2,
          dateTime: dateTime,
          costo: costo,
          lugar: lugar,
          especialidad: especialidad,
          tipo: tipo));
    }
    return citas;
  }*/

  static addCita(Cita cita) {
    CollectionReference citas =
        FirebaseFirestore.instance.collection('appoinments');

    citas.add({
      "pacient": cita.paciente.toMap(),
      "professional": cita.profesional.toMap(),
      "dateTime": cita.dateTime,
      "cost": cita.costo,
      "place": cita.lugar,
      "area": cita.especialidad,
      "type": cita.tipo,
      "state": cita.estado
    });
  }

  static removeCita(String id) {}
}
