import 'package:hablemos/model/profesional.dart';

///Clase encargada de almacenar la cantidad de dinero que debe ser pagada por el [profesional] al administrador por el uso del servicio
///
///Cuando el profesional termina una cita, se agrega esa cita a [listCitasProfesional] y se adiciona el porcentaje del costo de la cita a [pago]
class Pagoadmin {
  String uid;
  Profesional profesional;
  int pago;
  List<Map<String, dynamic>> listCitasProfesional;

  Pagoadmin({this.uid, this.profesional, this.pago, this.listCitasProfesional});

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
      "citas": mapa,
      "uid": uid,
    };
  }

  static fromMap(data) {
    Pagoadmin pa = Pagoadmin(
        uid: data["uid"],
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
