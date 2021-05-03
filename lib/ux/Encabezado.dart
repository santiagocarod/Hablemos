import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../constants.dart';

class EncabezadoHablemos extends StatelessWidget {
  const EncabezadoHablemos({
    Key key,
    @required this.size,
    this.text1,
  }) : super(key: key);

  final Size size;
  final String text1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.18,
      width: size.width,
      decoration: BoxDecoration(
          color: kAzulPrincipal,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(100),
            bottomRight: Radius.circular(100),
          )),
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: size.height * 0.05, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Hola $text1,',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                            color: kBlanco,
                            fontWeight: FontWeight.normal,
                            fontSize: 30.0,
                            fontFamily: 'RalewayRegular'),
                      )),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(bottom: 3),
                    child: Row(
                      children: <Widget>[
                        Container(
                            child: Text(
                          'H',
                          style: Theme.of(context).textTheme.headline3.copyWith(
                              color: kRojoOscuro,
                              fontWeight: FontWeight.bold,
                              fontSize: 53.0,
                              fontFamily: 'RalewayExtraBold'),
                        )),
                        Container(
                            child: Text(
                          'a',
                          style: Theme.of(context).textTheme.headline3.copyWith(
                              color: kRosado,
                              fontWeight: FontWeight.bold,
                              fontSize: 53.0,
                              fontFamily: 'RalewayExtraBold'),
                        )),
                        Container(
                            child: Text(
                          'b',
                          style: Theme.of(context).textTheme.headline3.copyWith(
                              color: kAmarillo,
                              fontWeight: FontWeight.bold,
                              fontSize: 53.0,
                              fontFamily: 'RalewayExtraBold'),
                        )),
                        Container(
                            child: Text(
                          'l',
                          style: Theme.of(context).textTheme.headline3.copyWith(
                              color: kAzulClaro,
                              fontWeight: FontWeight.bold,
                              fontSize: 53.0,
                              fontFamily: 'RalewayExtraBold'),
                        )),
                        Container(
                            child: Text(
                          'e',
                          style: Theme.of(context).textTheme.headline3.copyWith(
                              color: kRojoOscuro,
                              fontWeight: FontWeight.bold,
                              fontSize: 53.0,
                              fontFamily: 'RalewayExtraBold'),
                        )),
                        Container(
                            child: Text(
                          'm',
                          style: Theme.of(context).textTheme.headline3.copyWith(
                              color: kRosado,
                              fontWeight: FontWeight.bold,
                              fontSize: 53.0,
                              fontFamily: 'RalewayExtraBold'),
                        )),
                        Container(
                            child: Text(
                          'o',
                          style: Theme.of(context).textTheme.headline3.copyWith(
                              color: kAmarillo,
                              fontWeight: FontWeight.bold,
                              fontSize: 53.0,
                              fontFamily: 'RalewayExtraBold'),
                        )),
                        Container(
                            child: Text(
                          's',
                          style: Theme.of(context).textTheme.headline3.copyWith(
                              color: kAzulClaro,
                              fontWeight: FontWeight.bold,
                              fontSize: 53.0,
                              fontFamily: 'RalewayExtraBold'),
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
