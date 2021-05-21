///Clase que guarda toda la información importante de un paciente
///
///Cuando se crea su [foto] esta como no válida, una vez el usaurio la actualiza se reemplaza por la URL
class Paciente {
  String uid;
  String nombre;
  String apellido;
  String foto;
  String correo;
  String ciudad;
  String fechaNacimiento;
  String telefono;
  String nombreContactoEmergencia;
  String telefonoContactoEmergencia;
  String relacionContactoEmergencia;

  Paciente(
      {this.uid,
      this.nombre,
      this.apellido,
      this.correo,
      this.ciudad,
      this.fechaNacimiento,
      this.telefono,
      this.nombreContactoEmergencia,
      this.telefonoContactoEmergencia,
      this.relacionContactoEmergencia,
      this.foto});

  toMap() {
    return {
      "uid": this.uid,
      "lastName": this.apellido,
      "name": this.nombre,
      "email": this.correo,
      "city": this.ciudad,
      "birthDate": this.fechaNacimiento,
      "phone": this.telefono,
      "picture": this.foto,
      "emergencyContactName": this.nombreContactoEmergencia,
      "emergencyContactPhone": this.telefonoContactoEmergencia,
      "emergencyContactRelationship": this.relacionContactoEmergencia
    };
  }

  String nombreCompleto() {
    return this.nombre + " " + this.apellido;
  }

  static fromMap(data) {
    Paciente p = Paciente(
        uid: data["uid"],
        nombre: data["name"],
        apellido: data["lastName"],
        correo: data["email"],
        ciudad: data["city"],
        fechaNacimiento: data["birthDate"],
        telefono: data["phone"],
        foto: data["picture"],
        nombreContactoEmergencia: data["emergencyContactName"],
        telefonoContactoEmergencia: data["emergencyContactPhone"],
        relacionContactoEmergencia: data["emergencyContactRelationship"]);
    return p;
  }
}
