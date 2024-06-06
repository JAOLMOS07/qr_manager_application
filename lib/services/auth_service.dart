import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> LogIn(String email, String password) async {
    User? user;
    try {
      user = (await _auth.signInWithEmailAndPassword(
              email: email.trim(), password: password))
          .user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No se encontró ningún usuario para ese correo electrónico.');
      } else if (e.code == 'wrong-password') {
        print('Se proporcionó una contraseña incorrecta para ese usuario.');
      } else {
        print(e.toString());
      }
    }

    return user;
  }

  Future<User?> getCurrentUser() async {
    User? user;
    try {
      user = _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }

    return user;
  }

  Future<UserCredential?> SingUp(String email, String password) async {
    UserCredential? user;
    try {
      user = (await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No se encontró ningún usuario para ese correo electrónico.');
      } else if (e.code == 'wrong-password') {
        print('Se proporcionó una contraseña incorrecta para ese usuario.');
      } else {
        print(e.toString());
      }
    }
    return user;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error al cerrar sesión: $e');
    }
  }
}
