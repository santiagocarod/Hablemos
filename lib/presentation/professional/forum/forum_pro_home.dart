import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/foro.dart';
import 'package:hablemos/services/providers/foros_provider.dart';
import 'package:hablemos/ux/atoms.dart';

class ForumProfesianalHome extends StatefulWidget {
  @override
  _ForumProfesianalHomeState createState() => _ForumProfesianalHomeState();
}

class _ForumProfesianalHomeState extends State<ForumProfesianalHome> {
  int actual;
  int paginaActual;

  @override
  void initState() {
    // TODO: implement initState
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
          crearForosUpper(size),
          bodyForos(context, size),
        ],
      ),
    );
  }

  Widget bodyForos(BuildContext context, Size size) {
    List<Foro> foros = ForoProvider.getForo();

    double paginas = foros.length / 5;

    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.27),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: size.width),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Tus publicaciones',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return grisSuave;
                    },
                  ),
                  shape:
                      MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
                    (Set<MaterialState> states) {
                      return RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0));
                    },
                  ),
                ),
              ),
            ),
          ),
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
