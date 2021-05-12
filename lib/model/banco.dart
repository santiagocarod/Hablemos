class Banco {
  String banco;
  String tipoCuenta;
  String numCuenta;

  Banco({this.banco, this.tipoCuenta, this.numCuenta});

  toMap() {
    return {
      "bank": this.banco,
      "numAccount": this.numCuenta,
      "type": this.tipoCuenta
    };
  }

  static fromMap(data) {
    Banco b = Banco(
        banco: data["bank"],
        numCuenta: data["numAccount"],
        tipoCuenta: data["type"]);

    return b;
  }

  String toString() {
    return banco + " " + tipoCuenta + " " + numCuenta;
  }
}
