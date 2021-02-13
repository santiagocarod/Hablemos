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
      child: Stack(
        children: <Widget>[
          Container(
            padding:
                EdgeInsets.only(left: size.width / 12, bottom: size.width / 5),
            height: size.height * 0.18,
            decoration: BoxDecoration(
                color: kAzulPrincipal,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(57),
                  bottomRight: Radius.circular(57),
                )),
            child: Row(
              children: <Widget>[
                Container(
                    child: Text(
                  'Hola $text1,',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: kBlanco, fontWeight: FontWeight.normal),
                )),
              ],
            ),
          ),
          Container(
            padding:
                EdgeInsets.only(left: size.width / 12, top: size.width / 6),
            child: Row(
              children: <Widget>[
                Container(
                    child: Text(
                  'H',
                  style: Theme.of(context).textTheme.headline3.copyWith(
                      color: kRojoOscuro, fontWeight: FontWeight.bold),
                )),
                Container(
                    child: Text(
                  'a',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: kRosado, fontWeight: FontWeight.bold),
                )),
                Container(
                    child: Text(
                  'b',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: kAmarillo, fontWeight: FontWeight.bold),
                )),
                Container(
                    child: Text(
                  'l',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: kAzulClaro, fontWeight: FontWeight.bold),
                )),
                Container(
                    child: Text(
                  'e',
                  style: Theme.of(context).textTheme.headline3.copyWith(
                      color: kRojoOscuro, fontWeight: FontWeight.bold),
                )),
                Container(
                    child: Text(
                  'm',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: kRosado, fontWeight: FontWeight.bold),
                )),
                Container(
                    child: Text(
                  'o',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: kAmarillo, fontWeight: FontWeight.bold),
                )),
                Container(
                    child: Text(
                  's',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: kAzulClaro, fontWeight: FontWeight.bold),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
