import 'package:flutter/material.dart';
import 'package:hablemos/inh_widget.dart';
import 'package:hablemos/start.dart';

void main() => runApp(MyApp());

// Initial Function ============================================================
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InhWidget(
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Avoid the debug message
        home: Home(),
      ),
    );
  }
}
