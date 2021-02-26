class CentroAtencion {
  String nombre;
  String ciudad;
  String departamento;
  String telefono;
  String horaAtencion;
  String correo;
  String ubicacion;

  CentroAtencion({
    this.nombre,
    this.ciudad,
    this.departamento,
    this.telefono,
    this.correo,
    this.ubicacion,
  }) {
    this.horaAtencion =
        DateTime.now().hour.toString() + ':' + DateTime.now().minute.toString();
  }
}
