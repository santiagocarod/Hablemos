import 'package:flutter/material.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/presentation/admin/pantallaInicioAdmin.dart';
import 'package:hablemos/presentation/admin/professionals_management/viewProfProfile.dart';
import 'package:hablemos/presentation/admin/profile/viewAdminProfile.dart';
import 'package:hablemos/presentation/home.dart';
import 'package:hablemos/presentation/pacient/forums/details.dart';
import 'package:hablemos/presentation/pacient/forums/topicList.dart';
import 'package:hablemos/presentation/pacient/forums/topics.dart';
import 'package:hablemos/presentation/pacient/appointments/dateDetails.dart';
import 'package:hablemos/presentation/pacient/health%20information/information.dart';
import 'package:hablemos/presentation/pacient/health%20information/informationDetails.dart';
import 'package:hablemos/presentation/pacient/profile/editProfile.dart';
import 'package:hablemos/presentation/pacient/profile/viewProfile.dart';
import 'package:hablemos/presentation/professional/forum/forum_pro_home.dart';
import 'package:hablemos/presentation/professional/forum/forum_pro_publicaciones.dart';
import 'package:hablemos/presentation/professional/forum/info_forum_pro.dart';
import 'package:hablemos/presentation/user/events/attachPaymentActivity.dart';
import 'package:hablemos/presentation/user/events/attachPaymentGroup.dart';
import 'package:hablemos/presentation/user/events/attachPaymentWorkShop.dart';
import 'package:hablemos/presentation/user/events/eventsMain.dart';
import 'package:hablemos/presentation/user/events/listActivities.dart';
import 'package:hablemos/presentation/user/events/listSupportGroups.dart';
import 'package:hablemos/presentation/user/events/listWorkshops.dart';
import 'package:hablemos/presentation/user/events/mainEventsSigned.dart';
import 'package:hablemos/presentation/user/events/showActivity.dart';
import 'package:hablemos/presentation/user/events/showSupportGroup.dart';
import 'package:hablemos/presentation/user/events/showWorkShop.dart';
import 'package:hablemos/presentation/user/events/subscribedActivity.dart';
import 'package:hablemos/presentation/user/events/subscribedGroup.dart';
import 'package:hablemos/presentation/user/events/subscribedWorkShop.dart';
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
import 'package:hablemos/presentation/user/networks.dart';
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
import 'package:hablemos/presentation/user/medialCenters/listMedicalCenters.dart';
import 'package:hablemos/presentation/user/medialCenters/mainMedicalCenters.dart';
import 'package:hablemos/presentation/user/medialCenters/detailsMedicalCenter.dart';
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
    'inicioAdministrador': (context) => PantallaInicioAdmin(),
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
    'eventosPrincipal': (context) => EventsMain(),
    'eventosPrincipalUsuario': (context) => EventsMainSigned(),
    'listarActividades': (context) => ListActivities(),
    'listarTalleres': (context) => ListWorkShops(),
    'listarGruposApoyo': (context) => ListSupportGroups(),
    'verActividad': (context) => ShowActivity(),
    'verTaller': (context) => ShowWorkShop(),
    'verGrupoApoyo': (context) => ShowSupportGroup(),
    'ForosPaciente': (context) => TopicInformation(),
    'ForosTemaPaciente': (context) => TopicList(),
    'DetalleForo': (context) => Details(),
    'redes': (context) => Networks(),
    'DetalleCita': (context) => DateDetails(),
    'Informacion': (context) => Information(),
    'DetalleInformacion': (context) => InformationDetails(),
    'principalCentrosMedicos': (context) => MainMedicalCenter(),
    'listCentrosMedicos': (context) => ListMedicalCenter(),
    'detailCentroMedico': (context) => DetailsMedicalCenter(),
    'verPerfil': (context) => ViewProfile(),
    'editarPerfil': (context) => EditProfile(),
    'adjuntarPagoTaller': (context) => AttachPaymentWorkShop(),
    'adjuntarPagoActividad': (context) => AttachPaymentActivity(),
    'adjuntarPagoGrupo': (context) => AttachPaymentGroup(),
    'tallerSubscripto': (context) => SubscribedWorkShop(),
    'actividadSubscripto': (context) => SubscribedActivity(),
    'grupoSubscripto': (context) => SubscribedGroup(),
    'adminViewProfile': (context) => ViewAdminProfile(),
    'adminManageProffessional': (context) => ViewProfProfileManagement(),
  };
}
