import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/foro.dart';
import 'package:hablemos/services/providers/foros_provider.dart';
import 'package:hablemos/ux/atoms.dart';

class TopicInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: crearAppBar('', null, 0, null),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          crearForosUpper(size, 'Foros', Icons.comment_bank_outlined),
          Padding(
            padding: EdgeInsets.only(top: 210.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: _categories(context, size),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
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
          onPressed: () {},
        ),
      ),
    );
  }
}

Widget _categories(BuildContext context, Size size) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          width: size.width,
          child: Text(
            "Selecciona el tema de \ntu interés.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: kNegro,
              fontFamily: 'PoppinsRegular',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        _topic(context, 'DEPRESIÓN', size),
        _topic(context, 'ANSIEDAD', size),
        _topic(context, 'TRASTORNOS', size),
      ],
    ),
  );
}

Widget _topic(BuildContext context, String text, Size size) {
  List<Foro> foros = ForoProvider.getForo();

  return Container(
    padding: EdgeInsets.only(top: 20.0, right: 60.0, left: 60.0),
    width: size.width,
    height: size.height * 0.13,
    child: ElevatedButton(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 17.0,
          color: Colors.black,
          fontFamily: 'PoppinSemiBold',
        ),
        textAlign: TextAlign.center,
      ),
      style: ElevatedButton.styleFrom(
        primary: kAzulClaro,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(378.0),
        ),
        shadowColor: Colors.black,
      ),
      onPressed: () {
        Navigator.pushNamed(context, 'ForosTemaPaciente', arguments: foros);
      },
    ),
  );
}
