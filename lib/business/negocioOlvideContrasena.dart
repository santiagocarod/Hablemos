import 'package:firebase_auth/firebase_auth.dart';

Future<bool> olvideMiContrasena(String email) async {
  bool error = false;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  try {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  } catch (e) {
    print(e);
    error = true;
  }
  print(error);
  return !error;
}