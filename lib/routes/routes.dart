import 'package:flutter/material.dart';
import '../presentation/pantallaInicio.dart';
import '../presentation/signin.dart';
import '../presentation/login.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (context) => SignInPage(),
    '/login/': (context) => LoginPage(),
    '/inicio/': (context) => PantallaInicio(),
  };
}
