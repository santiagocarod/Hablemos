import 'package:flutter/material.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/presentation/home.dart';
import 'package:hablemos/presentation/pacient/appointments/dateDetails.dart';
import 'package:hablemos/presentation/pacient/health%20information/information.dart';
import 'package:hablemos/presentation/pacient/health%20information/informationDetails.dart';
import 'package:hablemos/presentation/professional/forum/forum_pro_home.dart';
import 'package:hablemos/presentation/professional/forum/forum_pro_publicaciones.dart';
import 'package:hablemos/presentation/professional/forum/info_forum_pro.dart';
import 'package:hablemos/presentation/user/exercises/breathe.dart';
import 'package:hablemos/presentation/user/exercises/info.dart';
import 'package:hablemos/presentation/user/exercises/meditation.dart';
import 'package:hablemos/presentation/user/exercises/mindfulness.dart';
import 'package:hablemos/presentation/user/exercises/options_breathe.dart';
import 'package:hablemos/presentation/user/exercises/options_exercises.dart';
import 'package:hablemos/presentation/pacient/letters/showLetter.dart';
import 'package:hablemos/presentation/pacient/appointments/list_professional.dart';
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
import '../presentation/pantallaInicioPaciente.dart';
import '../presentation/signin.dart';
import '../presentation/login.dart';
import 'package:hablemos/presentation/pacient/appointments/list_citas.dart';
import 'package:hablemos/presentation/professional/appointments/verPagoPro.dart';
import 'package:hablemos/presentation/pacient/appointments/attatchPayment.dart';
import 'package:hablemos/presentation/pacient/appointments/createDate.dart';
import 'package:hablemos/presentation/pacient/letters/listLetters.dart';
import 'package:hablemos/presentation/pacient/letters/addLetter.dart';
import 'package:hablemos/presentation/pantallaInicioProfesional.dart';

final Profesional profesional = ProfesionalesProvider.getProfesional();

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (context) => Home(),
    'start': (context) => StartFireBase(),
    'login': (context) => LoginPage(),
    'registro': (context) => SignInPage(),
    'inicio': (context) => PantallaInicioPacinete(),
    'inicioProfesional': (context) => PantallaInicioProfesional(),
    'citasPaciente': (context) => ListCitas(),
    'detalleProfesional': (context) => ListProfessional(),
    'detalleCitasProfesional': (context) =>
        DetalleCitaPro(profesional: profesional),
    'citasProfesional': (context) => ListCitasPro(),
    'CrearCita': (context) => CreateDate(),
    'VerPagoPro': (context) => VerPagoPro(),
    'AdjuntarPago': (context) => AttatchPayment(),
    'ForosProfesionalHome': (context) => ForumProfesianalHome(),
    'ForosTusPublicaciones': (context) => ForumProPublicaciones(),
    'InformacionForoProfesional': (context) => InfoForumProfesional(),
    'OpcionesEjercicios': (context) => OptionsExercises(),
    'opcionesRespirar': (context) => OptionsBreathe(),
    'respirar': (context) => BreatheClass(),
    'meditar': (context) => MeditationClass(),
    'mindfulness': (context) => MindfulnessClass(),
    'infoEjercicio': (context) => InfoClass(),
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
    'DetalleCita': (context) => DateDetails(),
    'Informacion': (context) => Information(),
    'DetalleInformacion': (context) => InformationDetails(),
  };
}
