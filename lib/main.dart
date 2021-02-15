import 'package:flutter/material.dart';
import 'start.dart';

void main() => runApp(MyApp());

// Initial Function ============================================================
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Avoid the debug message
      home: Home(),
    );
  }
}
