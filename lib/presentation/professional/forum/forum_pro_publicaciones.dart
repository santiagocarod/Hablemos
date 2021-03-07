import 'package:flutter/material.dart';
import 'package:hablemos/model/foro.dart';
import 'package:hablemos/services/providers/foros_provider.dart';
import 'package:hablemos/ux/atoms.dart';

class ForumProPublicaciones extends StatefulWidget {
  @override
  _ForumProPublicacionesState createState() => _ForumProPublicacionesState();
}

class _ForumProPublicacionesState extends State<ForumProPublicaciones> {
  int actual;
  int paginaActual;

  @override
  void initState() {
    super.initState();
    actual = 0;
    paginaActual = 1;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: crearAppBar('', null, 0, null),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          crearForosUpper(size, 'Tus Publicaciones', null),
          bodyForos(context, size),
        ],
      ),
    );
  }

  Widget bodyForos(BuildContext context, Size size) {
    List<Foro> foros = ForoProvider.getForo();

    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.27),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: size.width),
          SizedBox(height: 15.0),
          boxesListForo(context, size, foros, actual),
          Container(
            height: 50,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          if (actual != 0) {
                            actual -= 5;
                          } else {
                            actual = 0;
                          }
                        },
                      );
                      print(actual);
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          if (actual < (foros.length - 5)) {
                            actual += 5;
                          } else {
                            actual = foros.length - 5;
                          }
                        },
                      );
                      print(actual);
                    },
                    child: Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
