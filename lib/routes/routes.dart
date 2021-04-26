import 'package:flutter/material.dart';
import 'package:hablemos/presentation/admin/events/addActivity.dart';
import 'package:hablemos/presentation/admin/events/addGroup.dart';
import 'package:hablemos/presentation/admin/events/addWorkShop.dart';
import 'package:hablemos/presentation/admin/events/eventsAdminMain.dart';
import 'package:hablemos/presentation/admin/events/listActivitiesAdmin.dart';
import 'package:hablemos/presentation/admin/events/listGroupsAdmin.dart';
import 'package:hablemos/presentation/admin/events/listWorkShopsAdmin.dart';
import 'package:hablemos/presentation/admin/events/modifyActivity.dart';
import 'package:hablemos/presentation/admin/events/modifyGroup.dart';
import 'package:hablemos/presentation/admin/events/modifyWorkShop.dart';
import 'package:hablemos/presentation/admin/events/viewActivityAdmin.dart';
import 'package:hablemos/presentation/admin/events/viewGroupAdmin.dart';
import 'package:hablemos/presentation/admin/events/viewWorkShopAdmin.dart';
import 'package:hablemos/presentation/admin/health%20information/informationAdmin.dart';
import 'package:hablemos/presentation/admin/health%20information/mainInformation.dart';
import 'package:hablemos/presentation/admin/health%20information/mainScreen.dart';
import 'package:hablemos/presentation/admin/health%20information/newInformation.dart';
import 'package:hablemos/presentation/admin/pantallaInicioAdmin.dart';
import 'package:hablemos/presentation/admin/professionals_management/createProfessionalAdmin.dart';
import 'package:hablemos/presentation/admin/professionals_management/editProfProfileAdmin.dart';
import 'package:hablemos/presentation/admin/professionals_management/viewProfProfile.dart';
import 'package:hablemos/presentation/admin/professionals_management/viewProfessionalsHome.dart';
import 'package:hablemos/presentation/admin/profile/viewAdminProfile.dart';
import 'package:hablemos/presentation/home.dart';
import 'package:hablemos/presentation/pacient/appointments/attatchPayment.dart';
import 'package:hablemos/presentation/pacient/appointments/createDate.dart';
import 'package:hablemos/presentation/pacient/appointments/dateDetails.dart';
import 'package:hablemos/presentation/pacient/appointments/list_citas.dart';
import 'package:hablemos/presentation/pacient/appointments/list_professional.dart';
import 'package:hablemos/presentation/pacient/health%20information/information.dart';
import 'package:hablemos/presentation/pacient/health%20information/informationDetails.dart';
import 'package:hablemos/presentation/pacient/letters/addLetter.dart';
import 'package:hablemos/presentation/pacient/letters/listLetters.dart';
import 'package:hablemos/presentation/pacient/letters/showLetter.dart';
import 'package:hablemos/presentation/pacient/profile/editProfile.dart';
import 'package:hablemos/presentation/pacient/profile/viewProfile.dart';
import 'package:hablemos/presentation/pantallaInicioProfesional.dart';
import 'package:hablemos/presentation/professional/appointments/detalleCitaPro.dart';
import 'package:hablemos/presentation/professional/appointments/list_citas_pro.dart';
import 'package:hablemos/presentation/professional/appointments/verPagoPro.dart';
import 'package:hablemos/presentation/professional/letters/addLetterPro.dart';
import 'package:hablemos/presentation/professional/letters/assesLetterPro.dart';
import 'package:hablemos/presentation/professional/letters/editLetterPro.dart';
import 'package:hablemos/presentation/professional/letters/listAprovedLettersPro.dart';
import 'package:hablemos/presentation/professional/letters/listToEvaluateLettersPro.dart';
import 'package:hablemos/presentation/professional/letters/mainLettersPro.dart';
import 'package:hablemos/presentation/professional/letters/showLetterPro.dart';
import 'package:hablemos/presentation/professional/profile/profile_pro_edit.dart';
import 'package:hablemos/presentation/professional/profile/profile_pro_view.dart';
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
import 'package:hablemos/presentation/user/map.dart';
import 'package:hablemos/presentation/user/medialCenters/detailsMedicalCenter.dart';
import 'package:hablemos/presentation/user/medialCenters/listMedicalCenters.dart';
import 'package:hablemos/presentation/user/medialCenters/mainMedicalCenters.dart';
import 'package:hablemos/presentation/user/networks.dart';
import 'package:hablemos/start.dart';

import '../presentation/login.dart';
import '../presentation/pantallaInicioPaciente.dart';
import '../presentation/signin.dart';

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
    'detalleCitasProfesional': (context) => DetalleCitaPro(),
    'citasProfesional': (context) => ListCitasPro(),
    'CrearCita': (context) => CreateDate(),
    'VerPagoPro': (context) => VerPagoPro(),
    'AdjuntarPago': (context) => AttatchPayment(),
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
    'redes': (context) => Networks(),
    'DetalleCita': (context) => DateDetails(),
    'Informacion': (context) => Information(),
    'DetalleInformacion': (context) => InformationDetails(),
    'Mapa': (context) => MapBoxClass(),
    'verPerfilProfesional': (context) => ProfileProView(),
    'editarPerfilProfesional': (context) => EditProfileProfesional(),
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
    'adminManageProffessional': (context) => HomeProfessionalsManagement(),
    'verPerfilProfManage': (context) => ViewProfProfileManagement(),
    'editarPerfilProfesionalManage': (context) =>
        EditProfileProfessionalAdmin(),
    'crearPerfilProfesionalManage': (context) =>
        CreateProfileProfessionalAdmin(),
    'mainScreen': (context) => MainScreen(),
    'mainInformation': (context) => MainInformation(),
    'information': (context) => InformationAdmin(),
    'newInformation': (context) => NewInformation(),
    'eventosAdministrador': (context) => EventsMainAdmin(),
    'listarActividadesAdmin': (context) => ListActivitiesAdmin(),
    'listarGruposAdmin': (context) => ListGroupsAdmin(),
    'listarTalleresAdmin': (context) => ListWorkShopsAdmin(),
    "verActividadAdmin": (context) => ViewActivityAdmin(),
    "verTallerAdmin": (context) => ViewWorkShopAdmin(),
    "verGrupoAdmin": (context) => ViewGroupAdmin(),
    "agregarActividad": (context) => AddActivity(),
    "agregarTaller": (context) => AddWorkShop(),
    "agregarGrupo": (context) => AddGroup(),
    "modificarActividad": (context) => ModifyActivity(),
    "modificarGrupo": (context) => ModifyGroup(),
    "modificarTaller": (context) => ModifyWorkShop(),
  };
}
