class Cita {
  String _uidPaciente;
  String _uidProfesional;
  DateTime _dateTime;
  int _costo;
  String _lugar;
  String _especialidad;
  String _tipo;
  bool _estado;


  Cita(this._uidPaciente, this._uidProfesional, this._dateTime, this._costo,
      this._lugar, this._especialidad, this._tipo){this._estado = false;}


}
