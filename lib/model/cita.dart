class Cita {
  String uidPaciente;
  String uidProfesional;
  DateTime dateTime;
  int costo;
  String lugar;
  String especialidad;
  String tipo;
  bool estado;

  Cita(
      {this.uidPaciente,
      this.uidProfesional,
      this.dateTime,
      this.costo,
      this.lugar,
      this.especialidad,
      this.tipo}) {
    this.estado = false;
  }
}
