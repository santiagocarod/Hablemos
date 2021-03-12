import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/foro.dart';
import 'package:hablemos/ux/atoms.dart';

class TopicList extends StatefulWidget {
  @override
  _TopicList createState() => _TopicList();
}

class _TopicList extends State<TopicList> {
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
    final List<Foro> foros = ModalRoute.of(context).settings.arguments;
    final List<String> names = [];

    foros.forEach((element) {
      names.add(element.titulo);
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBar('', null, 0, null),
      body: Stack(
        children: <Widget>[
          crearForosUpper(
              size, 'Foros', Icons.comment_bank_outlined, 0.13, kAzulClaro),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _searchBar(size, names, foros),
                _cards(context, size, foros, actual),
                _scroll(foros),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _bottomBar(size),
    );
  }

  Widget _bottomBar(Size size) {
    return Container(
      padding: EdgeInsets.only(left: 60.0, right: 60.0, bottom: 25.0),
      width: size.width,
      height: 73.33,
      child: ElevatedButton(
        child: Text(
          'VER MÁS INFORMACIÓN DE SALUD MENTAL',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.black,
            fontFamily: 'PoppinsRegular',
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
          primary: kGris,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(378.0),
          ),
          shadowColor: Colors.black,
        ),
        onPressed: () {
          Navigator.pushNamed(context, 'Informacion');
        },
      ),
    );
  }

  Widget _searchBar(Size size, List<String> names, List<Foro> foros) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: () {
          showSearch(
              context: context,
              delegate: DataSearch(
                  names: names, elements: foros, route: 'DetalleForo'));
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
    );
  }

  Widget _cards(BuildContext context, Size size, List<Foro> foros, int numero) {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                'DetalleForo',
                arguments: foros[index],
              );
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
                        '${foros[numero + index].titulo}',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${foros[numero + index].descripcion}',
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

  Widget _scroll(List<Foro> foros) {
    return Container(
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
              },
              child: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }
}
