import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/diagnostico.dart';
import 'package:hablemos/services/providers/trastornos_provider.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:hablemos/ux/card_Information.dart';

class MainInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBar('', null, 0, null),
      body: Stack(
        children: <Widget>[
          _background(size),
          _appBar(size),
          Container(
            padding: EdgeInsets.only(top: size.height * 0.15),
            child: Column(
              children: [
                _swiperCards(size),
                _button(context, size),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Display background
Widget _background(Size size) {
  return Image.asset(
    'assets/images/purpleBackground.png',
    alignment: Alignment.center,
    fit: BoxFit.fill,
    width: size.width,
    height: size.height,
  );
}

// Display AppBar
Widget _appBar(Size size) {
  return Center(
    child: Container(
      padding: EdgeInsets.only(top: size.height * 0.05, bottom: 10.0),
      child: Column(
        children: <Widget>[
          Text(
            'Información',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PoppinsRegular',
              fontSize: 21.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

// Display Cards
Widget _swiperCards(Size size) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      width: size.width,
      height: size.height * 0.6,
      child: CardInformation(
        list: TrastornoProvider.getTrastorno(),
      ),
    ),
  );
}

// Display add button
Widget _button(BuildContext context, Size size) {
  return Container(
    padding: EdgeInsets.only(top: 30.0),
    child: SizedBox(
      width: 195.85,
      height: 61.96,
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              size: 28.0,
              color: kNegro,
            ),
            SizedBox(width: 10.0),
            Text(
              'AGREGAR',
              style: TextStyle(
                fontSize: 17.0,
                color: Colors.black,
                fontFamily: 'PoppinRegular',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          primary: grisSuave,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(378.0),
          ),
          shadowColor: Colors.black,
        ),
        onPressed: () {
          Diagnostico trastorno;
          Navigator.pushNamed(context, 'newInformation', arguments: trastorno);
        },
      ),
    ),
  );
}
