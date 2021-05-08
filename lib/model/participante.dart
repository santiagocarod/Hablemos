class Participante {
  String nombre;
  String apellido;
  String correo;
  String telefono;

  Participante({this.nombre, this.apellido, this.correo, this.telefono});

  toMap() {
    return {
      "name": this.nombre,
      "lastName": this.apellido,
      "email": this.correo,
      "phone": this.telefono,
    };
  }

  String nombreCOmpleto() {
    return this.nombre + " " + this.apellido;
  }

  static frommap(data) {
    Participante p = Participante(
      nombre: data["name"],
      apellido: data["lastName"],
      correo: data["email"],
      telefono: data["telefono"],
    );
    return p;
  }
}
