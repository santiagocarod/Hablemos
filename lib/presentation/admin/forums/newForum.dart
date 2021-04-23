import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/foro.dart';
import 'package:hablemos/services/providers/foros_provider.dart';
import 'package:hablemos/ux/atoms.dart';

class NewForum extends StatefulWidget {
  @override
  _NewForum createState() => _NewForum();
}

class _NewForum extends State<NewForum> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _contentController = new TextEditingController();
  final Foro foro = ForoProvider.getForo()[0];

  @override
  Widget build(BuildContext context) {
    //final Tema tema = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBar('', null, 0, null),
      body: Stack(
        children: <Widget>[
          _background(size),
          _appBar(size),
          SingleChildScrollView(
            child: Container(
              height: size.height,
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: 30),
                  _bodyInfoForum(context, size),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _background(Size size) {
    return Image.asset(
      'assets/images/purpleBackground.png',
      alignment: Alignment.center,
      fit: BoxFit.fill,
      width: size.width,
      height: size.height,
    );
  }

  Widget _appBar(Size size) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: size.height * 0.05, bottom: 10.0),
        child: Column(
          children: <Widget>[
            Text(
              'Foros',
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
            height: 41.0,
            color: kPurpura,
            child: Center(
              child: Text(
                'TU RESPUESTA',
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'PoppinsRegular',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ),
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
        padding: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              enableInteractiveSelection: false,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "NOMBRE FORO",
                hintStyle: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'PoppinsRegular',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {},
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: _contentController,
              enableInteractiveSelection: false,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "Contenído Foro",
                hintStyle: TextStyle(
                  fontFamily: 'PoppinsRegular',
                  fontSize: 20.0,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(41.0),
          color: kMoradoClarito,
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
      width: size.width - 15.0,
      height: size.height * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              // TODO: Save info forum
              showDialog(
                context: context,
                builder: (BuildContext context) => _adviceDialog(context),
              );
            },
            child: Row(
              children: [
                Icon(
                  Icons.save,
                  size: 20.0,
                ),
                Text(
                  ' Crear',
                  style: TextStyle(
                    fontFamily: 'PoppinsRegular',
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: size.width * 0.5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'response', arguments: foro);
            },
            child: Row(
              children: [
                Icon(
                  Icons.add_circle_outline,
                  size: 20.0,
                ),
                Text(
                  ' Responder',
                  style: TextStyle(
                    fontFamily: 'PoppinsRegular',
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Confirm popup dialog
  Widget _adviceDialog(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Foro Creado',
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: kNegro, width: 2.0),
      ),
      actions: <Widget>[
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(378.0),
                side: BorderSide(color: kNegro),
              ),
              shadowColor: Colors.black,
            ),
            child: const Text(
              'Cerrar',
              style: TextStyle(
                color: kNegro,
                fontSize: 14.0,
                fontFamily: 'PoppinsRegular',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
