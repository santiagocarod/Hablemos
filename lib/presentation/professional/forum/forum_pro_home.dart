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
          crearForosUpper(size, 'Foros', Icons.forum, 0.13, kAzulClaro),
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
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'ForosTusPublicaciones');
                },
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
          //SizedBox(height: 15.0),
          _boxesListForo(context, size, foros, actual),
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

  Widget _boxesListForo(
      BuildContext context, Size size, List<Foro> listadoForos, int numero) {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'InformacionForoProfesional');
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
              height: 200,
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '${listadoForos[numero + index].titulo}',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${listadoForos[numero + index].descripcion}',
                        style: TextStyle(fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(30.0),
                    bottomEnd: Radius.circular(30.0),
                    topStart: Radius.circular(30.0),
                    topEnd: Radius.circular(30.0),
                  ),
                  color: listColoresForo[index % listColoresForo.length],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                      offset: Offset(0.0, 2.0),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
