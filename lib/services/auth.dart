import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  Future<User> getCurrentUser();
  Future<User> logIn(String email, String password);
  Future<String> signUp(String email, String password, String displayName);
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
    UserCredential user;
    try {
      user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      return null;
    }

    return user.user;
  }

  @override
  Future<void> logOut() async {
    _firebaseAuth.signOut();
  }

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
