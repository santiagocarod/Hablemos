import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

const listaColoresEjercicios = [
  kVerdeMuyClaro,
  kRojoMuyClaro,
  kAzul1,
];

const listaColoresAdmin = [
  kMorado,
  kMoradoClarito,
  kPurpura,
];

class CardSwiper extends StatelessWidget {
  final List<dynamic> list;
  final String route;

  CardSwiper({@required this.list, this.route});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Color> listaColores;

    if (route == 'infoEjercicio') {
      listaColores = new List<Color>.from(listaColoresEjercicios);
    } else {
      listaColores = new List<Color>.from(listaColoresAdmin);
    }

    return Container(
      width: double.infinity,
      height: size.height * 0.55,
      child: Swiper(
        autoplay: true,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.8,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, route, arguments: list[index]);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0),
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(30.0),
                    bottomEnd: Radius.circular(30.0),
                    topStart: Radius.circular(30.0),
                    topEnd: Radius.circular(30.0),
                  ),
                  color: listaColores[index % listaColores.length],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                      offset: Offset(0.0, 2.0),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      list[index].titulo,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PoppinsBold',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Text(
                        list[index].descripcion,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'PoppinsRegular',
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: list.length,
      ),
    );
  }
}
