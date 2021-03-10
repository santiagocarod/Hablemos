import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/foro.dart';
import 'package:hablemos/model/tema.dart';
import 'package:hablemos/ux/atoms.dart';

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Foro foro = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBar('', null, 0, null),
      body: Stack(
        children: <Widget>[
          crearForosUpper(size, 'Foros', Icons.comment_bank_outlined),
          Padding(
            padding: EdgeInsets.only(top: 210.0),
            child: SingleChildScrollView(
              child: _body(context, size, foro),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _body(BuildContext context, Size size, Foro foro) {
  return Container(
    padding: EdgeInsets.only(top: 20.0),
    width: size.width,
    height: size.height,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _card(context, size, foro),
        SizedBox(height: 20.0),
        _answers(context, size, foro),
      ],
    ),
  );
}

Widget _card(BuildContext context, Size size, Foro foro) {
  return Container(
    width: size.width * 0.7,
    height: size.height * 0.4,
    padding: EdgeInsets.only(right: 10.0, left: 10.0, bottom: 10.0, top: 20.0),
    child: Column(
      children: <Widget>[
        Text(
          foro.titulo,
          style: TextStyle(
            fontSize: 17.0,
            fontFamily: 'PoppinsRegular',
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          foro.descripcion,
          style: TextStyle(
            fontSize: 17.0,
            fontFamily: 'PoppinsRegular',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadiusDirectional.only(
        bottomStart: Radius.circular(30.0),
        bottomEnd: Radius.circular(30.0),
        topStart: Radius.circular(30.0),
        topEnd: Radius.circular(30.0),
      ),
      color: kMoradoClaro,
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 10.0,
          spreadRadius: 0.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
  );
}

Widget _answers(BuildContext context, Size size, Foro foro) {
  final Tema tema = foro.temas[0];
  return Expanded(
    child: ListView.builder(
      itemCount: tema.respuestas.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding:
              EdgeInsets.only(top: 5.0, right: 10.0, left: 10.0, bottom: 5.0),
          height: 80,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 72.0,
                width: 72.0,
                color: kAzulClaro,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(13.0),
                  child: Icon(Icons.account_box_rounded,
                      color: Colors.black, size: 50.0),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10.0, left: 10.0),
                width: size.width - 92.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tema.respuestas[index].nombrePublicador,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontFamily: 'PoppinsSemiBold',
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        tema.respuestas[index].cuerpoRespuesta,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'PoppinsRegular',
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.40),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
