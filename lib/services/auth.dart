import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  Future<User> getCurrentUser();
  Future<User> logIn(String email, String password);
  Future<String> signUp(String email, String password, String displayName);
  Future<void> logOut();
}

/// Clase con metodos generales para el manejo de sesiones en Firebase
///
/// Principalmente usa metodos de [FirebaseAuth]
class AuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Metodo que obtiene el usuario que esta actualmente en sesión
  @override
  Future<User> getCurrentUser() async {
    User user = _firebaseAuth.currentUser;
    return user;
  }

  /// Metodo para iniciar sesión,
  ///
  /// Retorna el usuario una vez haya podido iniciar sesion
  /// En caso de error retorna `null`
  @override
  Future<User> logIn(String email, String password) async {
    UserCredential user;
    try {
      user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      return null;
    }

    return user.user;
  }

  /// Metodo para salir de sesión
  @override
  Future<void> logOut() async {
    _firebaseAuth.signOut();
  }

  /// Método para crear una cuenta con un correo y una contraseña
  @override
  Future<String> signUp(
      String email, String password, String displayName) async {
    UserCredential user;
    try {
      user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      user.user.updateProfile(displayName: displayName);
    } catch (error) {
      return (error.toString());
    }
    user.user.sendEmailVerification();
    return user.user.uid;
  }
}
