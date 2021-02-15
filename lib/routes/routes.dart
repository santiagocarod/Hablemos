import 'package:flutter/material.dart';
import 'package:hablemos/start.dart';
import '../presentation/pantallaInicio.dart';
import '../presentation/signin.dart';
import '../presentation/login.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (context) => Home(),
    'login': (context) => LoginPage(),
    'registro': (context) => SignInPage(),
    'inicio': (context) => PantallaInicio(),
  };
}
