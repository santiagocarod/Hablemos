class Diagnostico {
  String id;
  String nombre;
  String definicion;
  List<String> sintomas;
  String autoayuda;
  List<String> fuentes;

  Diagnostico(
      {this.id,
      this.nombre,
      this.definicion,
      this.autoayuda,
      this.sintomas,
      this.fuentes});

  toMap() {
    return {
      "name": this.nombre,
      "definition": this.definicion,
      "symptoms": this.sintomas,
      "selfhelp": this.autoayuda,
      "reference": this.fuentes
    };
  }

  static fromMap(data, id) {
    return Diagnostico(
        id: id,
        nombre: data["name"],
        definicion: data["definition"],
        sintomas: List<String>.from(data["symptoms"]),
        autoayuda: data["selfhelp"],
        fuentes: List<String>.from(data["reference"]));
  }
}
