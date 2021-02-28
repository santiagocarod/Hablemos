import 'package:hablemos/model/carta.dart';

class CartaProvider {
  static List<Carta> getCarta() {
    List<Carta> cartas = [];

    for (int i = 0; i < 2; i++) {
      String titulo = 'Carta aprobada # $i'; //Titulo carta aprobadda 1
      String titulo2 = 'Carta no aprobada $i'; //Titulo carta aprobada 2

      String cuerpo =
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry.';

      //Creacion una aprobada y otra no aprobada
      Carta c = new Carta(titulo: titulo, cuerpo: cuerpo, aprobado: true);
      Carta c2 = new Carta(titulo: titulo2, cuerpo: cuerpo, aprobado: false);

      cartas..add(c)..add(c2);
    }

    return cartas;
  }
}
