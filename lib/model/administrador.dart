class Administrador {
  String correo;
  String ciudad;
  String permisos;
  String nombre;
  String apellido;

  Administrador({
    this.ciudad,
    this.apellido,
    this.correo,
    this.nombre,
    this.permisos,
  }) {
    this.permisos = 'Todos';
  }
}
