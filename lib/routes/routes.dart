import 'package:flutter/material.dart';
import '../presentation/signin.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (context) => SignInPage(),
  };
}
