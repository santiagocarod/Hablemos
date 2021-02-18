class Cita {
  String _uidPaciente;
  String _uidProfesional;
  DateTime _dateTime;
  int _costo;
  String _lugar;
  String _especialidad;
  String _tipo;
  bool _estado;

  String get uidPaciente => _uidPaciente;

  set uidPaciente(String value) {
    _uidPaciente = value;
  }

  String get uidProfesional => _uidProfesional;

  bool get estado => _estado;

  set estado(bool value) {
    _estado = value;
  }

  String get tipo => _tipo;

  set tipo(String value) {
    _tipo = value;
  }

  String get especialidad => _especialidad;

  set especialidad(String value) {
    _especialidad = value;
  }

  String get lugar => _lugar;

  set lugar(String value) {
    _lugar = value;
  }

  int get costo => _costo;

  set costo(int value) {
    _costo = value;
  }

  DateTime get dateTime => _dateTime;

  set dateTime(DateTime value) {
    _dateTime = value;
  }

  set uidProfesional(String value) {
    _uidProfesional = value;
  }
}
