import 'banco.dart';

/// Clase encargada de guardar la información de los profesionales
///
/// Tienen dos listas, [convenios] con EPS o otras empresas para que el paciente tenga esa información en cuenta
/// [proyectos] principales en los que puede decir que ha trabajado
/// [banco] referencia a su cuenta Bancaria para que el paciente pueda realizar el pago
class Profesional {
  String uid;
  String nombre;
  String apellido;
  String fechaNacimiento;
  String especialidad;
  String experiencia;
  String ciudad;
  List<String> convenios;
  List<String> proyectos;
  String descripcion;
  String foto;
  Banco banco;
  String celular;
  String correo;

  Profesional(
      {this.uid,
      this.nombre,
      this.apellido,
      this.fechaNacimiento,
      this.especialidad,
      this.experiencia,
      this.convenios,
      this.proyectos,
      this.banco,
      this.celular,
      this.ciudad,
      this.descripcion,
      this.correo,
      this.foto});

  toMap() {
    return {
      "uid": this.uid,
      "name": this.nombre,
      "lastName": this.apellido,
      "birthDate": this.fechaNacimiento,
      "speciality": this.especialidad,
      "experience": this.experiencia,
      "contracts": this.convenios,
      "projects": this.proyectos,
      "bank": this.banco.toMap(),
      "phone": this.celular,
      "email": this.correo,
      "city": this.ciudad,
      "description": this.descripcion,
      "picture": this.foto,
    };
  }

  toMapPago() {
    return {
      "uid": this.uid,
      "name": this.nombre,
      "lastName": this.apellido,
    };
  }

  static Profesional fromMap(data) {
    Profesional p = Profesional(
        uid: data["uid"],
        nombre: data["name"],
        apellido: data["lastName"],
        banco: data["bank"] == null ? null : Banco.fromMap(data["bank"]),
        fechaNacimiento: data["birthDay"],
        especialidad: data["speciality"],
        experiencia: data["experience"],
        convenios: data["contracts"] == null
            ? null
            : List<String>.from(data["contracts"]),
        proyectos: data["projects"] == null
            ? null
            : List<String>.from(data["projects"]),
        celular: data["phone"],
        ciudad: data["city"],
        descripcion: data["description"],
        correo: data["email"],
        foto: data["picture"]);

    return p;
  }

  String nombreCompleto() {
    return this.nombre + " " + this.apellido;
  }

  ///Sobre-escritura del operador`==` para poder comparar si dos profesionales son iguales
  ///
  ///Se compara por medio de su UID
  bool operator ==(other) {
    return (other is Profesional) && other.uid == uid;
  }

  ///Funcion necesaria para la sobreescritura del operador `==`
  int get hashCode => uid.hashCode;
}
