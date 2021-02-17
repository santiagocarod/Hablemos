import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  Future<User> getCurrentUser();
  Future<User> logIn(String email, String password);
  Future<User> signUp(String email, String password);
  Future<void> logOut();
}

class AuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User> getCurrentUser() async {
    User user = _firebaseAuth.currentUser;
    return user;
  }

  @override
  Future<User> logIn(String email, String password) async {
    User user = _firebaseAuth.currentUser;
    return user;
  }

  @override
  Future<void> logOut() async {
    _firebaseAuth.signOut();
  }

  @override
  Future<User> signUp(String email, String password) async {
    UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }
}
