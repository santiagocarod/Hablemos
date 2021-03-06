import 'package:flutter/material.dart';
import 'package:hablemos/ux/atoms.dart';

class ForumProfesianalHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: crearAppBar('', null, 0, null),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          crearForosUpper(size),
          Container(
            height: size.height,
            width: size.width,
            child: Center(
              child: bodyForos(size),
            ),
          ),
        ],
      ),
    );
  }

  Widget bodyForos(Size size) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.3),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: size.width),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Tus publicaciones'),
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Text('Hola'),
          ],
        ),
      ),
    );
  }
}
