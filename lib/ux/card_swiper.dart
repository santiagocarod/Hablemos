import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/ejercicio.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<Ejercicio> list;

  CardSwiper({@required this.list});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.55,
      child: Swiper(
        autoplay: true,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.8,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
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
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    list[index].descripcion,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: list.length,
      ),
    );
  }
}
