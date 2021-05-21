import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hablemos/model/diagnostico.dart';
import 'package:hablemos/presentation/admin/health%20information/newInformation.dart';

/// Clase que contiene el card con la informacion ya organizada, se usa en diferentes pantallas

const listaColoresAdmin = [
  kMorado,
  kMoradoClarito,
  kPurpura,
];

class CardInformation extends StatelessWidget {
  final List<Diagnostico> list;

  CardInformation({@required this.list});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        autoplay: false,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.8,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NewInformation(
                        trastorno: list[index],
                      )));
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
                        fontSize: 29.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PoppinsBold',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Center(
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 30.0, right: 30.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          maxLines: 12,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            text: list[index].definicion,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsRegular',
                            ),
                          ),
                        ),
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
