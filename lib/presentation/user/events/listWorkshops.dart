import 'package:flutter/material.dart';
import 'package:hablemos/model/taller.dart';
import 'package:hablemos/services/providers/eventos_provider.dart';
import 'package:hablemos/ux/atoms.dart';

import '../../../constants.dart';

class ListWorkShops extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final List<String> names = [];
  @override
  Widget build(BuildContext context) {
    List<Taller> talleres = EventoProvider.getTalleres();
    Size size = MediaQuery.of(context).size;
    talleres.forEach((element) {
      names.add(element.titulo);
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBarEventos(context, "Talleres", "eventosPrincipal"),
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/eventsSpecificBackground.png',
            alignment: Alignment.center,
            fit: BoxFit.fill,
            width: size.width,
            height: size.height,
          ),
          searchBar(
              context, size, searchController, names, talleres, "verTaller"),
          Material(
            type: MaterialType.transparency,
            child: Padding(
              padding: EdgeInsets.only(top: size.height * 0.27),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: objectCard(context, size, talleres),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> objectCard(
    BuildContext context, Size size, List<Taller> talleres) {
  List<Widget> cards = [];
  talleres.forEach((element) {
    Card card = Card(
      elevation: 0,
      margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
      color: Colors.transparent,
      child: Center(
        child: Stack(
          children: <Widget>[
            Container(
              width: 333.0,
              height: 185.0,
              decoration: BoxDecoration(
                image: element.foto,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 7.0,
                      color: Colors.grey.withOpacity(0.5)),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 333.0,
                    decoration: BoxDecoration(
                      color: kBlanco.withOpacity(0.8),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                    ),
                    child: Column(
                      children: <Widget>[
                        Text("${element.titulo}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 20, fontFamily: "PoppinsRegular")),
                        Text("${element.fecha}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 20, fontFamily: "PoppinsRegular")),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
    InkWell inkWell = InkWell(
      splashColor: kRosado,
      onTap: () {
        Navigator.pushNamed(context, "verTaller", arguments: element);
      },
      child: card,
    );
    cards.add(inkWell);
  });
  return cards;
}
