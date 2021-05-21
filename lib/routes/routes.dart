/// Este documento contiene todas las rutas definidas que son usadas para la comunicación entre pantallas y la navegabilidad de la aplicación
///
/// Incluye las rutas y los imports usados para todos los tipos de usuarios: [Usuario], [Paciente], [Profesional] y [Administrador].

/// Establece todos los imports usados para las referencia a las pantallas del [Usuario]
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
import 'package:hablemos/presentation/user/medialCenters/filterMedicalCenter.dart';
import 'package:hablemos/presentation/user/medialCenters/listMedicalCenters.dart';
import 'package:hablemos/presentation/user/medialCenters/mainMedicalCenters.dart';
import 'package:hablemos/presentation/user/networks.dart';

/// Establece todos los imports usados para las referencia a las pantallas del [Paciente]
import 'package:hablemos/presentation/pacient/appointments/attatchPayment.dart';
import 'package:hablemos/presentation/pacient/appointments/createDate.dart';
import 'package:hablemos/presentation/pacient/appointments/dateDetails.dart';
import 'package:hablemos/presentation/pacient/appointments/list_citas.dart';
import 'package:hablemos/presentation/pacient/appointments/list_professional.dart';
import 'package:hablemos/presentation/pacient/appointments/professionalDetails.dart';
import 'package:hablemos/presentation/pacient/health%20information/information.dart';
import 'package:hablemos/presentation/pacient/health%20information/informationDetails.dart';
import 'package:hablemos/presentation/pacient/letters/addLetter.dart';
import 'package:hablemos/presentation/pacient/letters/listLetters.dart';
import 'package:hablemos/presentation/pacient/letters/showLetter.dart';
import 'package:hablemos/presentation/pacient/profile/editProfile.dart';
import 'package:hablemos/presentation/pacient/profile/viewProfile.dart';

/// Establece todos los imports usados para las referencia a las pantallas del [Profesional]
import 'package:hablemos/presentation/professional/appointments/detalleCitaPro.dart';
import 'package:hablemos/presentation/professional/appointments/editarCita.dart';
import 'package:hablemos/presentation/professional/appointments/list_citas_pro.dart';
import 'package:hablemos/presentation/professional/appointments/pacientDetails.dart';
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

/// Establece todos los imports usados para las referencia a las pantallas del [Administrador]
import 'package:hablemos/presentation/admin/MedicalCenter/detailMedicalAdmin.dart';
import 'package:hablemos/presentation/admin/MedicalCenter/listMedicalAdmin.dart';
import 'package:hablemos/presentation/admin/MedicalCenter/newMedicalCenter.dart';
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
import 'package:hablemos/presentation/admin/events/viewParticipantsEvent.dart';
import 'package:hablemos/presentation/admin/events/viewWorkShopAdmin.dart';
import 'package:hablemos/presentation/admin/health%20information/informationAdmin.dart';
import 'package:hablemos/presentation/admin/health%20information/mainInformation.dart';
import 'package:hablemos/presentation/admin/health%20information/newInformation.dart';
import 'package:hablemos/presentation/admin/pantallaInicioAdmin.dart';
import 'package:hablemos/presentation/admin/payments/detailedPayment.dart';
import 'package:hablemos/presentation/admin/payments/mainPayments.dart';
import 'package:hablemos/presentation/admin/professionals_management/createProfessionalAdmin.dart';
import 'package:hablemos/presentation/admin/professionals_management/editProfProfileAdmin.dart';
import 'package:hablemos/presentation/admin/professionals_management/viewProfProfile.dart';
import 'package:hablemos/presentation/admin/professionals_management/viewProfessionalsHome.dart';
import 'package:hablemos/presentation/admin/profile/viewAdminProfile.dart';

///Establece todos los imports adicionales que estan asociados al correctofuncionamiento de Dart
///
/// Establece igualmente imports relacionados con el registro e inicio de sesión que corresponde a todos los usuarios
import 'package:flutter/material.dart';
import 'package:hablemos/presentation/forgotPassword.dart';
import 'package:hablemos/presentation/home.dart';
import 'package:hablemos/presentation/pantallaInicioProfesional.dart';
import 'package:hablemos/presentation/signInMinor.dart';
import 'package:hablemos/presentation/verifyEmail.dart';
import 'package:hablemos/start.dart';
import '../presentation/login.dart';
import '../presentation/pantallaInicioPaciente.dart';
import '../presentation/signin.dart';

/// Indica la tabla de enrutamiento de la aplicación
///
/// Hace la asignacion de cada cadena a una la función correspondiente que retorna el widget para el despliega de cada pantalla
Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    /// Rutas asociadas al [Usuario]
    ///
    /// Indica las rutas asociadas la la seccion de los ejercicios.
    'OpcionesEjercicios': (context) => OptionsExercises(),
    'opcionesRespirar': (context) => OptionsBreathe(),
    'respirar': (context) => BreatheClass(),
    'meditar': (context) => MeditationClass(),
    'mindfulness': (context) => MindfulnessClass(),
    'infoEjercicio': (context) => InfoClass(),

    /// Indica las rutas asociadas a la seccion de los eventos, incluyendo: [Actividad]es, [Taller]es, [Grupo]s.
    'eventosPrincipal': (context) => EventsMain(),
    'eventosPrincipalUsuario': (context) => EventsMainSigned(),
    'listarActividades': (context) => ListActivities(),
    'listarGruposApoyo': (context) => ListSupportGroups(),
    'listarTalleres': (context) => ListWorkShops(),
    'verActividad': (context) => ShowActivity(),
    'verTaller': (context) => ShowWorkShop(),
    'verGrupoApoyo': (context) => ShowSupportGroup(),
    'adjuntarPagoTaller': (context) => AttachPaymentWorkShop(),
    'adjuntarPagoActividad': (context) => AttachPaymentActivity(),
    'adjuntarPagoGrupo': (context) => AttachPaymentGroup(),
    'tallerSubscripto': (context) => SubscribedWorkShop(),
    'actividadSubscripto': (context) => SubscribedActivity(),
    'grupoSubscripto': (context) => SubscribedGroup(),

    /// Indica las rutas asociadas a las redes
    'redes': (context) => Networks(),

    /// Indica las rutas asociadas la seccion de los [Diagnostico]s
    'Informacion': (context) => Information(),
    'DetalleInformacion': (context) => InformationDetails(),

    /// Indica las rutas asociadas a la seccion de los [Centro_Atencion]
    'Mapa': (context) => MapBoxClass(),
    'principalCentrosMedicos': (context) => MainMedicalCenter(),
    'listCentrosMedicos': (context) => ListMedicalCenter(),
    'detailCentroMedico': (context) => DetailsMedicalCenter(),
    "filterMedicalCenters": (context) => FilterMedicalCenter(),

    /// Rutas asociadas al [Paciente]
    ///
    /// Indica las rutas asociadas a la pantalla principal de los usuarios registrados como [Paciente]s.
    'inicio': (context) => PantallaInicioPacinete(),

    /// Indica las rutas asociadas a la seccion de las [Cita]s para los [Paciente]s.
    'citasPaciente': (context) => ListCitas(),
    'CrearCita': (context) => CreateDate(),
    'AdjuntarPago': (context) => AttatchPayment(),
    'listaCartasPaciente': (context) => ListLetters(),
    'DetalleCita': (context) => DateDetails(),
    'detalleProfesional': (context) => ListProfessional(),

    /// Indica las rutas asociadas a la seccion de las [Carta]s para los [Paciente]s.
    'agregarCarta': (context) => AddLetter(),
    'verCarta': (context) => ShowLetter(),

    /// Indica las rutas asociadas a la seccion del perfil del [Paciente]
    'verPerfil': (context) => ViewProfile(),
    'editarPerfil': (context) => EditProfile(),
    'professionalDetails': (context) => ProfessionalDetails(),

    /// Rutas asociadas al [Profesional]
    ///
    /// Indica las rutas asociadas a la pantalla principal de los usuarios registrados como [Profesional].
    'inicioProfesional': (context) => PantallaInicioProfesional(),

    /// Indica las rutas asociadas a la seccion de las [Cita]s para los [Profesional]es.
    'detalleCitasProfesional': (context) => DetalleCitaPro(),
    'editarCitaProfesional': (context) => EditCitaPro(),
    'citasProfesional': (context) => ListCitasPro(),
    'pacientDetails': (context) => PacientDetails(),
    'VerPagoPro': (context) => VerPagoPro(),

    /// Indica las rutas asociadas a la seccion de las [Carta]s para los [Profesional]es.
    'cartasPrincipalProfesional': (context) => MainLettersPro(),
    'listarCartasPro': (context) => ListAprovedLettersPro(),
    'valorarCartaPro': (context) => AssesLetterPro(),
    'verCartaPro': (context) => ShowLetterPro(),
    'escribirCartaPro': (context) => AddLetterPro(),
    'listaCartasEvaluar': (context) => ListToEvaluateLettersPro(),
    'editarCartaPro': (context) => EditLetterPro(),

    /// Indica las rutas asociadas a la seccion del perfil del [Profesional]
    'verPerfilProfesional': (context) => ProfileProView(),
    'editarPerfilProfesional': (context) => EditProfileProfesional(),

    /// Rutas asociadas al [Administrador]
    ///
    /// Indica las rutas asociadas a la pantalla principal del usuario [Administrador].
    'inicioAdministrador': (context) => PantallaInicioAdmin(),

    /// Indica las rutas asociadas a la seccion del perfil del [Administrador]
    'adminViewProfile': (context) => ViewAdminProfile(),

    /// Indica las rutas asociadas a la seccion de profesionales
    'adminManageProffessional': (context) => HomeProfessionalsManagement(),
    'verPerfilProfManage': (context) => ViewProfProfileManagement(),
    'editarPerfilProfesionalManage': (context) =>
        EditProfileProfessionalAdmin(),
    'crearPerfilProfesionalManage': (context) =>
        CreateProfileProfessionalAdmin(),

    /// Indica las rutas asociadas a la seccion de los [Diagnostico]s para el [Administrador]
    'mainInformation': (context) => MainInformation(),
    'information': (context) => InformationAdmin(),
    'newInformation': (context) => NewInformation(),

    /// Indica las rutas asociadas la seccion de los eventos, que incluyen: [Actividad], [Taller], [Grupo], para el [Administrador]
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
    "verListaDeInscritos": (context) => ParticipantsEvent(),

    /// Indica las rutas asociadas a la seccion de los [Centro_Atencion], para el usuario [Administrador]
    "listCentrosMedicosAdmin": (context) => ListMedicalAdmin(),
    "detailsCentrosMedicosAdmin": (context) => DetailsMedicalAdmin(),
    "newCentrosMedicosAdmin": (context) => NewMedicalAdmin(),

    /// Indica las rutas asociadas a la seccion de los [Pagodmin]
    "principalPagoAdmin": (context) => MainPaymentsPage(),
    "detayledPaymentAdmin": (context) => DetailedPaymentAdmin(),

    /// Indica las rutas adicionales
    ///
    /// Estas son rutas asociadas con el registro y el despliegue de las pantalla principales de la aplicación
    '/': (context) => Home(),
    'start': (context) => StartFireBase(),
    'login': (context) => LoginPage(),
    'registro': (context) => SignInPage(),
    'registroMenorEdad': (context) => SingInMinor(),
    "verifyEmail": (context) => VerifyEmail(),
    "olvideConstrasena": (context) => ForgotPassword(),
  };
}
