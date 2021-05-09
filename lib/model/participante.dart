class Participante {
  String nombre;
  String apellido;
  String correo;
  String telefono;
  String uid;
  String pago;

  Participante({
    this.nombre,
    this.apellido,
    this.correo,
    this.telefono,
    this.uid,
    this.pago,
  });

  toMap() {
    return {
      "name": this.nombre,
      "lastName": this.apellido,
      "email": this.correo,
      "phone": this.telefono,
      "uid": this.uid,
      "payment": this.pago,
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
      pago: data["payment"],
    );
    return p;
  }
}
