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
      "symtoms": this.sintomas,
      "selfhelp": this.autoayuda,
      "reference": this.fuentes
    };
  }

  static fromMap(data, id) {
    return Diagnostico(
        id: id,
        nombre: data["name"],
        definicion: data["definition"],
        sintomas: data["symtoms"],
        autoayuda: data["selfhelp"],
        fuentes: data["reference"]);
  }
}
