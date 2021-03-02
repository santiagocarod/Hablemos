import 'package:flutter/material.dart';
import 'package:hablemos/ux/atoms.dart';

class BreatheClass extends StatefulWidget {
  @override
  _BreatheClassState createState() => _BreatheClassState();
}

class _BreatheClassState extends State<BreatheClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: crearAppBar('', null, 0, null),
      body: Center(
        child: Text('aaaa'),
      ),
    );
  }
}
