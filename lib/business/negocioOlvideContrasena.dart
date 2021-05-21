import 'package:firebase_auth/firebase_auth.dart';

///Se envia un correo de Recuperación a [email]
///
///En caso de que el usuario no exista, retorna `false`
Future<bool> olvideMiContrasena(String email) async {
  bool error = false;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  try {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  } catch (e) {
    error = true;
  }
  return !error;
}
