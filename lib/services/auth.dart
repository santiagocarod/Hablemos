import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  Future<User> getCurrentUser();
  Future<String> logIn(String email, String password);
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
  Future<String> logIn(String email, String password) async {
    UserCredential user;
    try {
      user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      return (error.toString());
    }

    return user.user.uid;
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
