import 'package:flutter/material.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/presentation/home.dart';
import 'package:hablemos/presentation/pacient/list_professional.dart';
import 'package:hablemos/presentation/professional/detalleCitaPro.dart';
import 'package:hablemos/presentation/professional/forum/forum_pro_home.dart';
import 'package:hablemos/presentation/professional/forum/forum_pro_publicaciones.dart';
import 'package:hablemos/presentation/professional/list_citas_pro.dart';
import 'package:hablemos/services/providers/profesionales_provider.dart';
import 'package:hablemos/start.dart';
import '../presentation/pantallaInicio.dart';
import '../presentation/signin.dart';
import '../presentation/login.dart';
import 'package:hablemos/presentation/pacient/list_citas.dart';
import 'package:hablemos/presentation/professional/verPagoPro.dart';
import 'package:hablemos/presentation/pacient/attatchPayment.dart';

final Profesional profesional = ProfesionalesProvider.getProfesional();

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (context) => Home(),
    'start': (context) => HomeScreen(),
    'login': (context) => LoginPage(),
    'registro': (context) => SignInPage(),
    'inicio': (context) => PantallaInicio(),
    'citasPaciente': (context) => ListCitas(),
    'detalleProfesional': (context) => ListProfessional(),
    'detalleCitasProfesional': (context) =>
        DetalleCitaPro(profesional: profesional),
    'citasProfesional': (context) => ListCitasPro(),
    'VerPagoPro': (context) => VerPagoPro(),
    'AdjuntarPago': (context) => AttatchPayment(),
    'ForosProfesionalHome': (context) => ForumProfesianalHome(),
    'ForosTusPublicaciones': (context) => ForumProPublicaciones(),
  };
}
