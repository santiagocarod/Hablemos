import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/actividad.dart';
import 'package:hablemos/util/snapshotConvertes.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/ux/loading_screen.dart';

/// Clase encargada de desplegar las Actividades disponibles con su información básica y fotos
///
/// Es encargada de ir a Firebase y traer todoos los eventos de tipo [Actividad]
class ListActivities extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final List<String> names = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    CollectionReference actividadesCollection =
        FirebaseFirestore.instance.collection('activities');

    return StreamBuilder<QuerySnapshot>(
      stream: actividadesCollection.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('ALGO SALIO MAL');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingScreen();
        }

        List<Actividad> actividades = actividadMapToList(snapshot);

        actividades.forEach((element) {
          if (!names.contains(element.titulo)) {
            names.add(element.titulo);
          }
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
                    context, "Actividades", "eventosPrincipal"),
                body: Stack(
                  children: <Widget>[
                    searchBar(context, size, 'Buscar Actividades', names,
                        actividades, "verActividad"),
                    Material(
                      type: MaterialType.transparency,
                      child: Padding(
                        padding: EdgeInsets.only(top: size.height * 0.27),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: objectCard(context, size, actividades),
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

/// Hace la transformación del objeto a una Card la cual puede ser vista de mejor manera
List<Widget> objectCard(
    BuildContext context, Size size, List<Actividad> actividades) {
  List<Widget> cards = [];
  actividades.forEach((element) {
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
                image: DecorationImage(image: NetworkImage(element.foto)),
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
        Navigator.pushNamed(context, "verActividad", arguments: element);
      },
      child: card,
    );
    cards.add(inkWell);
  });
  return cards;
}
