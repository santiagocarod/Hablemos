import 'package:hablemos/model/profesional.dart';

class Pagoadmin {
  Profesional profesional;
  int pago;
  List<Map<String, dynamic>> listCitasProfesional;

  Pagoadmin({this.profesional, this.pago, this.listCitasProfesional});

  toMap() {
    List<Map<String, dynamic>> mapa = [];
    listCitasProfesional.forEach((element) {
      mapa.add({"fecha": element["fecha"], "name": element["name"]});
    });
    return {
      "professional": {
        "id": profesional.uid,
        "lastname": profesional.apellido,
        "name": profesional.nombre
      },
      "payment": pago,
      "citas": mapa
    };
  }

  static fromMap(data) {
    Pagoadmin pa = Pagoadmin(
        profesional: Profesional(
            uid: data["professional"]["id"],
            nombre: data["professional"]["name"],
            apellido: data["professional"]["lastname"]),
        pago: data["payment"]);
    pa.listCitasProfesional = [];
    List<Map<String, dynamic>> listaCitas =
        data["citas"].cast<Map<String, dynamic>>().toList();
    pa.listCitasProfesional = listaCitas;

    return pa;
  }
}
