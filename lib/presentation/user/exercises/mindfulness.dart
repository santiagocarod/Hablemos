import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/services/providers/exercises_provider.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/ux/card_swiper.dart';

class MindfulnessClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: crearAppBar('', null, 0, null),
        body: Stack(
          children: <Widget>[
            _superior(size),
            _swiperCards(size),
          ],
        ),
      ),
    );
  }

  Widget _superior(Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.65,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 100.0),
          Icon(
            Icons.access_alarm_outlined,
            size: 60.0,
          ),
          SizedBox(height: 10.0),
          Text(
            'Mindfulnes',
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            child: Text(
              'Seleccciona el ejercicio que desees',
              style: TextStyle(
                fontSize: 25.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(30.0),
          bottomEnd: Radius.circular(30.0),
        ),
        color: kAmarilloMuyClaro,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 2.0),
          )
        ],
      ),
    );
  }

  Widget _swiperCards(Size size) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: size.width,
        height: size.height * 0.6,
        child: CardSwiper(
          list: ExerciseProvider.getMindfulnes(),
          route: 'infoEjercicio',
        ),
      ),
    );
  }
}
