class Trastorno {
  //TODO: RECORDAR CAMBIAR NOMBRE CLASE

  String uid;
  String nombre;
  String definicion;
  List<String> sintomas;
  String autoayuda;
  List<String> fuentes;

  Trastorno(
      {this.uid,
      this.nombre,
      this.definicion,
      this.autoayuda,
      this.sintomas,
      this.fuentes});
}