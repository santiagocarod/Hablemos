import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/tema.dart';
import 'package:hablemos/services/providers/foros_provider.dart';
import 'package:hablemos/ux/atoms.dart';

class InfoForumProfesional extends StatelessWidget {
  final Tema tema = ForoProvider.getForo()[0].temas[0];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: crearAppBar('', null, 0, null),
        body: Stack(
          children: [
            Image.asset(
              'assets/images/azulDegradado.png',
              alignment: Alignment.topCenter,
              fit: BoxFit.fill,
              width: size.width,
              height: size.height,
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.0),
              child: SingleChildScrollView(
                child: Container(
                  height: size.height,
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      _bodyInfoForum(context, size),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bodyInfoForum(BuildContext context, Size size) {
    return Expanded(
      child: Column(
        children: <Widget>[
          SizedBox(height: size.height * 0.10),
          _widgetInfoForo(context, size),
          SizedBox(height: 20),
          _widgetBotonesTema(context, size),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 20.0,
            color: Colors.amber,
            child: Center(
              child: Text('Respuestas'),
            ),
          ),
          _widgetRespuestasTema(context, size),
        ],
      ),
    );
  }

  Widget _widgetInfoForo(BuildContext context, Size size) {
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Container(
        width: size.width * 0.7,
        height: size.width * 0.4,
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text(
              tema.nombrePublicador,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              tema.cuerpo,
              style: TextStyle(
                fontSize: 20.0,
              ),
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
          color: kAmarillo,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
              spreadRadius: 0.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _widgetBotonesTema(BuildContext context, Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Icon(Icons.add),
                Text('Responder'),
              ],
            ),
          ),
          SizedBox(
            width: size.width * 0.5,
          ),
          GestureDetector(
            onTap: () => _mostrarAlert(context),
            child: Row(
              children: [
                Icon(Icons.remove),
                Text('Eliminar'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetRespuestasTema(BuildContext context, Size size) {
    return Expanded(
      child: ListView.builder(
        itemCount: tema.respuestas.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            height: 50,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: size.width * 0.6,
                  child: Text(
                    'Holaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.drag_handle_rounded),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _mostrarAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          title: Text('Confirmacion de eliminación'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('¿Está seguro que desea eliminar esta tema?'),
              FlutterLogo(size: 100),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Si'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('No'),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
