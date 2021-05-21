///Centros de atención independiente de la organización de La Papaya
///
///Estos son centros de atención de ayuda psicologica que atienden Emergencias y son especializados
///Información útil que dispone la aplicación.
class CentroAtencion {
  String id;
  String nombre;
  String ciudad;
  String departamento;
  String telefono;
  String horaAtencion;
  String correo;
  String ubicacion;
  bool gratuito;

  CentroAtencion(
      {this.id,
      this.nombre,
      this.ciudad,
      this.departamento,
      this.telefono,
      this.correo,
      this.ubicacion,
      this.gratuito,
      this.horaAtencion});

  toMap() {
    return {
      "name": this.nombre,
      "city": this.ciudad,
      "state": this.departamento,
      "telephone": this.telefono,
      "email": this.correo,
      "location": this.ubicacion,
      "free": this.gratuito,
      "hours": this.horaAtencion
    };
  }

  static fromMap(data, id) {
    return CentroAtencion(
        id: id,
        nombre: data["name"],
        ciudad: data["city"],
        departamento: data["state"],
        telefono: data["telephone"],
        correo: data["email"],
        ubicacion: data["location"],
        gratuito: data["free"],
        horaAtencion: data["hours"]);
  }
}
