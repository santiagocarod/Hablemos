import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hablemos/model/profesional.dart';

abstract class AuthBase {
  Future<User> getCurrentUser();
  Future<String> logIn(String email, String password);
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

  Future<Profesional> getProfesional() async {
    Profesional profesional;
    User user = await getCurrentUser();

    FirebaseFirestore.instance.collection("professionals").doc(user.uid);
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

    return user.user.uid;
  }
}
