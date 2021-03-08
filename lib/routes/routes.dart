import 'package:flutter/material.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/presentation/home.dart';
import 'package:hablemos/presentation/pacient/letters/showLetter.dart';
import 'package:hablemos/presentation/pacient/list_professional.dart';
import 'package:hablemos/presentation/professional/appointments/detalleCitaPro.dart';
import 'package:hablemos/presentation/professional/appointments/list_citas_pro.dart';
import 'package:hablemos/presentation/professional/letters/addLetterPro.dart';
import 'package:hablemos/presentation/professional/letters/editLetterPro.dart';
import 'package:hablemos/presentation/professional/letters/listToEvaluateLettersPro.dart';
import 'package:hablemos/presentation/professional/letters/mainLettersPro.dart';
import 'package:hablemos/presentation/professional/letters/assesLetterPro.dart';
import 'package:hablemos/presentation/professional/letters/listAprovedLettersPro.dart';
import 'package:hablemos/presentation/professional/letters/showLetterPro.dart';
import 'package:hablemos/services/providers/profesionales_provider.dart';
import 'package:hablemos/start.dart';
import '../presentation/pantallaInicio.dart';
import '../presentation/signin.dart';
import '../presentation/login.dart';
import 'package:hablemos/presentation/pacient/list_citas.dart';
import 'package:hablemos/presentation/professional/appointments/verPagoPro.dart';
import 'package:hablemos/presentation/pacient/attatchPayment.dart';
import 'package:hablemos/presentation/pacient/letters/listLetters.dart';
import 'package:hablemos/presentation/pacient/letters/addLetter.dart';

final Profesional profesional = ProfesionalesProvider.getProfesional();

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (context) => Home(),
    'start': (context) => StartFireBase(),
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
    'cartasPrincipalProfesional': (context) => MainLettersPro(),
    'listarCartasPro': (context) => ListAprovedLettersPro(),
    'valorarCartaPro': (context) => AssesLetterPro(),
    'verCartaPro': (context) => ShowLetterPro(),
    'escribirCartaPro': (context) => AddLetterPro(),
    'listaCartasEvaluar': (context) => ListToEvaluateLettersPro(),
    'editarCartaPro': (context) => EditLetterPro(),
    'listaCartasPaciente': (context) => ListLetters(),
    'agregarCarta': (context) => AddLetter(),
    'verCarta': (context) => ShowLetter(),
  };
}
