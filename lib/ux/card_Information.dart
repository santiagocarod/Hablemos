import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hablemos/model/trastorno.dart';

const listaColoresAdmin = [
  kMorado,
  kMoradoClarito,
  kPurpura,
];

class CardInformation extends StatelessWidget {
  final List<Trastorno> list;

  CardInformation({@required this.list});

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
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'information',
                  arguments: list[index]);
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
                  color: listaColoresAdmin[index % listaColoresAdmin.length],
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
                      list[index].nombre,
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
                        list[index].definicion,
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
