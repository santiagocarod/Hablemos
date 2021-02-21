import 'package:flutter/material.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/presentation/home.dart';
import 'package:hablemos/presentation/professional/detalleCitaPro.dart';
import 'package:hablemos/services/providers/profesionales_provider.dart';
import 'package:hablemos/start.dart';
import '../presentation/pantallaInicio.dart';
import '../presentation/signin.dart';
import '../presentation/login.dart';
import '../presentation/pacient/dateDetails.dart';
import 'package:hablemos/services/providers/citas_provider.dart';
import 'package:hablemos/model/cita.dart';

final List<Cita> citas = CitasProvider.getCitas();
final Cita cita = citas[0];
final Profesional profesional = ProfesionalesProvider.getProfesional();

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (context) => Home(),
    'start': (context) => HomeScreen(),
    'login': (context) => LoginPage(),
    'registro': (context) => SignInPage(),
    'inicio': (context) => PantallaInicio(),
    'dateDetails': (context) => DateDetails(cita: citas[0]),
    'detalleCitaPro': (context) => DetalleCitaPro(profesional: profesional)
  };
}
