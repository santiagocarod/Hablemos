import 'package:flutter/material.dart';

import 'constants.dart';

// Initial screen, shows only the start button (COMENZAR) ======================

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        _background(context, size),
        _letras(context, size),
        _startButton(context, size),
      ],
    );
  }
}

Widget _background(BuildContext context, Size size) {
  return Image(
    height: size.height,
    width: size.width,
    image: AssetImage("assets/images/start_image.png"),
    fit: BoxFit.cover,
  );
}

Widget _letras(BuildContext context, Size size) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: double.infinity,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(width: 20.0),
          Container(
              child: Text(
            'H',
            style: Theme.of(context).textTheme.headline3.copyWith(
                color: kRojoOscuro,
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.15,
                fontFamily: 'RalewayExtraBold'),
          )),
          Container(
              child: Text(
            'a',
            style: Theme.of(context).textTheme.headline3.copyWith(
                color: kRosado,
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.15,
                fontFamily: 'RalewayExtraBold'),
          )),
          Container(
              child: Text(
            'b',
            style: Theme.of(context).textTheme.headline3.copyWith(
                color: kAmarillo,
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.15,
                fontFamily: 'RalewayExtraBold'),
          )),
          Container(
              child: Text(
            'l',
            style: Theme.of(context).textTheme.headline3.copyWith(
                color: kAzulClaro,
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.15,
                fontFamily: 'RalewayExtraBold'),
          )),
          Container(
              child: Text(
            'e',
            style: Theme.of(context).textTheme.headline3.copyWith(
                color: kRojoOscuro,
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.15,
                fontFamily: 'RalewayExtraBold'),
          )),
          Container(
              child: Text(
            'm',
            style: Theme.of(context).textTheme.headline3.copyWith(
                color: kRosado,
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.15,
                fontFamily: 'RalewayExtraBold'),
          )),
          Container(
              child: Text(
            'o',
            style: Theme.of(context).textTheme.headline3.copyWith(
                color: kAmarillo,
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.15,
                fontFamily: 'RalewayExtraBold'),
          )),
          Container(
              child: Text(
            's',
            style: Theme.of(context).textTheme.headline3.copyWith(
                color: kAzulClaro,
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.15,
                fontFamily: 'RalewayExtraBold'),
          )),
          SizedBox(width: 20.0),
        ],
      ),
    ],
  );
}

Widget _startButton(BuildContext context, Size size) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      SizedBox(
        width: double.infinity,
      ),
      SizedBox(
        width: double.infinity,
      ),
      SizedBox(
        width: double.infinity,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 50.0),
          SizedBox(
            height: 42.0,
            child: ElevatedButton(
              child: Text(
                "COMENZAR",
                style: TextStyle(
                    fontSize: 21.0,
                    color: Colors.black,
                    letterSpacing: 3,
                    fontFamily: 'PoppinSemiBold'),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              onPressed: () {
                /*AuthService authService = new AuthService();
              authService.signUp("santiago@gmail.com", "123456");
              print(
              "User : ${authService.getCurrentUser().then((value) => print(value))}");*/
                String direccion = "Calle 127D # 19 - 83";
                Navigator.pushNamed(context, 'Mapa', arguments: direccion);
              },
            ),
          ),
          SizedBox(width: 50.0),
        ],
      ),
      SizedBox(
        width: double.infinity,
      )
    ],
  );
}
