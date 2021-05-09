import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/ux/atoms.dart';
import '../../../constants.dart';

class EventsMainAdmin extends StatefulWidget {
  @override
  _EventsMainAdminState createState() => _EventsMainAdminState();
}

class _EventsMainAdminState extends State<EventsMainAdmin> {
  int tamTalleres = 0;
  int tamActividad = 0;
  int tamGrupos = 0;

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance.collection("workshops").get().then((value) {
      tamTalleres = value.size;
      setState(() {});
    });
    FirebaseFirestore.instance.collection("activities").get().then((value) {
      tamActividad = value.size;
      setState(() {});
    });
    FirebaseFirestore.instance.collection("groups").get().then((value) {
      tamGrupos = value.size;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: kAmarilloClaro,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: crearAppBarEventos(context, "Eventos", 'inicioAdministrador'),
          body: Stack(
            children: <Widget>[
              Image.asset(
                'assets/images/eventsAdminBackground.png',
                alignment: Alignment.center,
                fit: BoxFit.fill,
                width: size.width,
                height: size.height,
              ),
              SingleChildScrollView(
                child: Container(
                    alignment: Alignment.center,
                    width: size.width,
                    child: Column(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              height: size.height * 0.15,
                            ),
                            _opciones(
                                context,
                                size,
                                Icons.transfer_within_a_station_outlined,
                                "Talleres",
                                tamTalleres,
                                'listarTalleresAdmin',
                                "agregarTaller"),
                            SizedBox(
                              height: size.height * 0.05,
                            ),
                            _opciones(
                                context,
                                size,
                                Icons.thumbs_up_down_outlined,
                                "Actividades",
                                tamActividad,
                                'listarActividadesAdmin',
                                "agregarActividad"),
                            SizedBox(
                              height: size.height * 0.05,
                            ),
                            _opciones(
                                context,
                                size,
                                Icons.people_alt_outlined,
                                "Grupos de Apoyo",
                                tamGrupos,
                                'listarGruposAdmin',
                                "agregarGrupo"),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBarEvento(
      String texto, IconData icono, int constante, Color color) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Icon(icono, color: color),
        ),
      ],
      title: Text(
        texto,
        style: TextStyle(
            color: kLetras, fontSize: 22.0, fontFamily: 'PoppinsRegular'),
      ),
      centerTitle: true,
      iconTheme: IconThemeData(
        color: kLetras, //change your color here
      ),
    );
  }
}

Widget _opciones(
  BuildContext context,
  Size size,
  IconData icon,
  String titulo,
  int cantidad,
  String rutaVisualizar,
  String rutaAdd,
) {
  cantidad.toString();
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, rutaVisualizar);
        },
        child: Container(
          height: 152.0,
          width: 285.5,
          alignment: Alignment.center,
          child: Center(
            child: Container(
              width: 215.5,
              height: 118.25,
              decoration: BoxDecoration(
                color: kAmarilloMuyClaro,
                borderRadius: BorderRadius.all(Radius.circular(80)),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 7.0,
                      color: Colors.grey.withOpacity(0.5)),
                ],
              ),
              child: Icon(
                icon,
                size: 89.0,
                color: kLetras,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: kAmarilloClaro,
            borderRadius: BorderRadius.all(Radius.circular(41)),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 7.0,
                  color: Colors.grey.withOpacity(0.5)),
            ],
          ),
        ),
      ),
      Container(
        width: 285.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "$titulo",
                    style: GoogleFonts.montserrat(
                        color: kLetras,
                        fontSize: 19.0,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "$cantidad",
                    style: GoogleFonts.montserrat(
                        color: kLetras,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, rutaAdd);
              },
              child: Container(
                margin: EdgeInsets.only(top: 10.0),
                height: 43.0,
                width: 43.0,
                decoration: BoxDecoration(
                  color: kBlanco,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 7.0,
                        color: Colors.grey.withOpacity(0.5)),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.add_circle_outline_outlined,
                    color: kNegro,
                    size: 28.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ],
  );
}
