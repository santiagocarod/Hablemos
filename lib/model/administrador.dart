///Clase que contiene la información básica del administrador del sistema
class Administrador {
  String uid;
  String correo;
  String ciudad;
  String permisos;
  String nombre;
  String apellido;

  Administrador({
    this.uid,
    this.ciudad,
    this.apellido,
    this.correo,
    this.nombre,
    this.permisos,
  }) {
    this.permisos = 'Todos';
  }

  toMap() {
    return {
      "uid": this.uid,
      "email": this.correo,
      "city": this.ciudad,
      "permissions": this.permisos,
      "name": this.nombre,
      "lastName": this.apellido
    };
  }

  static fromMap(data) {
    Administrador a = Administrador(
      nombre: data["name"],
      apellido: data["lastName"],
      correo: data["email"],
      ciudad: data["city"],
      permisos: data["permissions"],
    );

    return a;
  }
}
