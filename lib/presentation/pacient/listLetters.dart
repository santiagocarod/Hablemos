import 'package:flutter/material.dart';
import 'package:hablemos/model/carta.dart';
import 'package:hablemos/services/providers/cartas_provider.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/constants.dart';

class ListLetters extends StatelessWidget {
  final List<Carta> cartas = CartaProvider.getCartas();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBar("Cartas", null, 0, null),
      body: Stack(
        children: <Widget>[
          //Background Image
          Image.asset(
            'assets/images/background.png',
            alignment: Alignment.center,
            fit: BoxFit.fill,
            width: size.width,
            height: size.height,
          ),
          // Contents
          Material(
            type: MaterialType.transparency,
            child: Padding(
              padding: EdgeInsets.only(top: 80.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: letterToCard(context, cartas),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kMostaza,
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

List<Widget> letterToCard(BuildContext context, List<Carta> cartas) {
  List<Widget> cards = [];
  cartas.forEach((element) {
    if (element.aprobado) {
      Card card = Card(
        elevation: 5,
        margin: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        shadowColor: Colors.black.withOpacity(1.0),
        child: Center(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Icon(Icons.mail),
            SizedBox(
              height: 5,
            ),
            Text("${element.titulo}",
                style: TextStyle(fontSize: 22, fontFamily: "PoppinSemiBold")),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 20),
              child: Text(
                  (element.cuerpo.length <= 250)
                      ? element.cuerpo
                      : "${element.cuerpo.substring(0, 250)} ...",
                  style: TextStyle(fontFamily: "PoppinsRegular", fontSize: 12)),
            )
          ],
        )),
      );
      InkWell inkWell = InkWell(
        splashColor: kRosado,
        onTap: () {},
        child: card,
      );
      cards.add(inkWell);
    }
  });
  return cards;
}
