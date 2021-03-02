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
}
