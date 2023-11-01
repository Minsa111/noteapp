// ignore_for_file: unnecessary_cast, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        return true; // Masuk berhasil
      } else {
        return false; // Masuk gagal
      }
    } on FirebaseAuthException catch (e) {
      print("Error during sign-in: ${e.message}");
      return false; // Penanganan kesalahan saat masuk
    }
  }
}
