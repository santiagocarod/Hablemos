import 'package:flutter/material.dart';
import 'package:hablemos/presentation/home.dart';
import 'package:hablemos/routes/routes.dart';

void main() => runApp(MyApp());

// Initial Function ============================================================
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Avoid the debug message
      initialRoute: '/',
      routes: getApplicationRoutes(),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      },
    );
  }
}
