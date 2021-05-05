import 'package:hablemos/model/profesional.dart';

class Pagoadmin {
  Profesional profesional;
  int pago;
  List<Map<String, dynamic>> listCitasProfesional;

  Pagoadmin({this.profesional, this.pago, this.listCitasProfesional});

  toMap() {
    return {
      "professional": {
        "id": profesional.uid,
        "lastname": profesional.apellido,
        "name": profesional.nombre
      },
      "payment": pago,
      "citas": listCitasProfesional.forEach((element) {
        return {"fecha": element["fecha"], "name": element["name"]};
      })
    };
  }

  static fromMap(data) {
    Pagoadmin pa = Pagoadmin(
        profesional: Profesional(
            uid: data["professional.id"],
            nombre: data["professional.name"],
            apellido: data["professional.lastname"]),
        pago: int.parse(data["payment"]),
        listCitasProfesional: data["citas"]);

    return pa;
  }
}
