class Carta {
  String id;
  String titulo;
  String cuerpo;
  bool aprobado;

  Carta({
    this.id,
    this.titulo,
    this.cuerpo,
    this.aprobado,
  });

  static Carta fromMap(data, id) {
    return Carta(
      id: id,
      titulo: data["title"],
      cuerpo: data["body"],
      aprobado: data["approved"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": this.titulo,
      "body": this.cuerpo,
      "approved": this.aprobado,
    };
  }
}
