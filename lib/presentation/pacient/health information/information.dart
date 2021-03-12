import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/model/trastorno.dart';
import 'package:hablemos/services/providers/trastornos_provider.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/ux/atoms.dart';

class Information extends StatelessWidget {
  final List<Trastorno> trastornos = TrastornoProvider.getTrastorno();
  final List<String> names = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    trastornos.forEach((element) {
      names.add(element.nombre);
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: crearAppBar('', null, 0, null),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          crearForosUpper(size, 'Informémonos \ny hablemos', Icons.monitor,
              0.05, kAmarillo),
          Padding(
            padding: EdgeInsets.only(top: 210.0, bottom: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        showSearch(
                            context: context,
                            delegate: DataSearch(
                                names: names,
                                elements: trastornos,
                                route: 'DetalleInformacion'));
                      },
                      child: Container(
                        width: size.width - 120.0,
                        height: 43.33,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(378.0),
                          border: Border.all(color: kRosado),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(left: 10.0),
                              child: Icon(
                                Icons.search_rounded,
                                color: kRosado,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Buscar Temas',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: kAzulOscuro,
                                    fontFamily: 'PoppinsSemiBold'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: _information(context, trastornos, size),
                    // ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 60.0, right: 60.0, bottom: 25.0),
        width: size.width,
        height: 73.33,
        child: ElevatedButton(
          child: Text(
            'Ver Foro',
            style: TextStyle(
              fontSize: 17.0,
              color: Colors.black,
              fontFamily: 'PoppinsRegular',
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          style: ElevatedButton.styleFrom(
            primary: kRosado,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(378.0),
            ),
            shadowColor: Colors.black,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}

List<Widget> _information(
    BuildContext context, List<Trastorno> trastornos, Size size) {
  List<Widget> topics = [];

  trastornos.forEach((element) {
    Container topic = Container(
      padding: EdgeInsets.only(left: 60.0, right: 60.0, bottom: 32.0),
      width: size.width,
      height: 73.33,
      child: ElevatedButton(
        child: Text(
          element.nombre,
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.black,
            fontFamily: 'PoppinsSemiBold',
          ),
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
          primary: kCuruba,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(378.0),
          ),
          shadowColor: Colors.black,
        ),
        onPressed: () {
          Navigator.pushNamed(context, 'DetalleInformacion',
              arguments: element);
        },
      ),
    );
    topics.add(topic);
  });

  return topics;
}