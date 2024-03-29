import 'package:flutter/material.dart';
import 'package:hablemos/cloudinary.dart';

/// Paleta de Colores utilizada dentro de la aplicación
const kAzulPrincipal = Color(0xFF202830);
const kAzulOscuro = Color(0xFF205072);
const kLetras = Color(0xFF302B2B);
const kBeigeFondo = Color(0xFFF7F6DD);
const kRojoOscuro = Color(0xFFE45865);
const kRosado = Color(0xFFFFD4C4);
const kBlanco = Color(0xFFFFFFFF);
const kAmarillo = Color(0xFFFCD06B);
const kAzulClaro = Color(0xFFE1FFFF);
const kMorado = Color(0xFFC08EF2);
const kVerdeClaro = Color(0xFFA5DF6E);
const kMostaza = Color(0xFFF6B662);
const kAmarilloClaro = Color(0xFFFFDE83);
const kAguaMarina = Color(0xFF46D4E1);
const kMarino = Color(0xFF8EE8D8);
const kNegro = Color(0xFF000000);
const kVerde = Color(0xFF4CAF50);
const kRojo = Color(0xFFF44336);
const kVerdeMuyClaro = Color(0xFFF0FFE2);
const kAmarilloMuyClaro = Color(0xFFF7F6DD);
const kRojoMuyClaro = Color(0xFFF9E8E1);
const kAzul1 = Color(0xFFE2FFEE);
const kAzul2 = Color(0xFFCFFFF7);
const kAzul3 = Color(0xFFAFF6EC);
const kAzulLetras = Color(0xFF1AC0C6);
const kMoradoClarito = Color(0xFFD8D0FF);
const kMoradoOscuro = Color(0xFF5233E8);
const kGrisN = Color(0xFFC4C4C4);
const kGris = Color(0xFFD8D0FF);
const kMoradoClaro = Color(0xFFE8E6F5);
const kCuruba = Color(0xFFF8DFA5);
const kPurpura = Color(0xFFDDACF5);
const kMoradoTitulo = Color(0xFF9A53BC);
const kMostazaOscuro = Color(0xFFC37E00);
const kVerdePagos = Color(0xFF28BE59);

const listaColores = [
  kVerdeMuyClaro,
  kRojoMuyClaro,
  kAzul1,
];

const listColoresForo = [
  Color(0xFFFCD06B),
  Color(0xFFFFD4C4),
  Color(0xFFE1FFFF),
  Color(0xFFC3EDD5),
  Color(0xFFF7F6DD),
];

const grisSuave = Color(0xFFEAECFF);

/// Constantes de claves y carpetas para Cloudinary
const API_KEY = CLOUDINARY_API_KEY;
const API_SECRET = CLOUDINARY_API_SECRET;
const CLOUD_NAME = "hablemos";
const PAY_FOLDER = "payment_pictures";
const PROFILE_FOLDER = "profile_pictures";
const ACTIVITY_FOLDER = "activity_pictures";
const GROUP_FOLDER = "group_pictures";
const WORKSHOP_FOLDER = "workshop_pictures";
const ACTIVITY_PAYMENT = "paymentsActivities";
const GROUP_PAYMENT = "paymentsGroups";
const WORKSHOP_PAYMENT = "paymentsWorkshops";

///Constantes Lógicas para ejecución
const HORA_INICIO_CONSULTAS = 7;
const HORA_FIN_CONSULTAS = 18;
const PORCENTAJE_PAGO = 5000;
const COSTO_CITA = 80000;
const TIPOS_DE_CITA = ['Proceso', 'Cita Unica'];
