import 'package:flutter/material.dart';
import 'package:hablemos/model/grupo.dart';
import 'package:hablemos/util/snapshotConvertes.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/ux/loading_screen.dart';

import '../../../constants.dart';

class ListSupportGroups extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final List<String> names = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CollectionReference gruposCollection =
        FirebaseFirestore.instance.collection("groups");
    return StreamBuilder<QuerySnapshot>(
      stream: gruposCollection.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('ALGO SALIO MAL');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingScreen();
        }

        List<Grupo> grupos = grupoMapToList(snapshot);

        grupos.forEach((element) {
          names.add(element.titulo);
        });

        return Stack(
          children: [
            Container(
              child: Image.asset(
                'assets/images/eventsSpecificBackground.png',
                alignment: Alignment.center,
                fit: BoxFit.fill,
                width: size.width,
                height: size.height,
              ),
            ),
            SafeArea(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset: false,
                extendBodyBehindAppBar: true,
                appBar: crearAppBarEventos(
                    context, "Grupos de Apoyo", "eventosPrincipal"),
                body: Stack(
                  children: <Widget>[
                    searchBar(context, size, searchController, names, grupos,
                        "verGrupoApoyo"),
                    Material(
                      type: MaterialType.transparency,
                      child: Padding(
                        padding: EdgeInsets.only(top: size.height * 0.27),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: objectCard(context, size, grupos),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

List<Widget> objectCard(BuildContext context, Size size, List<Grupo> grupos) {
  List<Widget> cards = [];
  grupos.forEach((element) {
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
        Navigator.pushNamed(context, "verGrupoApoyo", arguments: element);
      },
      child: card,
    );
    cards.add(inkWell);
  });
  return cards;
}
