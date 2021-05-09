class Participante {
  String nombre;
  String apellido;
  String correo;
  String telefono;
  String uid;

  Participante({
    this.nombre,
    this.apellido,
    this.correo,
    this.telefono,
    this.uid,
  });

  toMap() {
    return {
      "name": this.nombre,
      "lastName": this.apellido,
      "email": this.correo,
      "phone": this.telefono,
      "uid": this.uid,
    };
  }

  String nombreCOmpleto() {
    return this.nombre + " " + this.apellido;
  }

  static fromMap(data) {
    Participante p = Participante(
      nombre: data["name"],
      apellido: data["lastName"],
      correo: data["email"],
      telefono: data["phone"],
      uid: data["uid"],
    );
    return p;
  }
}
