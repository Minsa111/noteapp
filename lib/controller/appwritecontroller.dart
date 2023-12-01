// ignore_for_file: unused_field, avoid_print, unnecessary_null_comparison

import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';

final client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('65631c1398656071fe82');

final account = Account(client);

class AppWriteAuthController extends GetxController {
  RxBool isLoggedIn = false.obs;
  RxString userIdToken = ''.obs;

  Future<bool> signUp(String email, String password) async {
    try {
      final uniqueUserId = ID.unique();
      final response = await account.create(
        userId: uniqueUserId,
        email: email,
        password: password,
      );
      final registrationSuccess = response != null;
      if (registrationSuccess) {
        userIdToken.value = response.$id;
        print('User registered successfully');
      }
      return registrationSuccess;
    } catch (e) {
      print('Error during registration: $e');
    }
    return false;
  }

  Future<bool> signIn(String email, String password) async {
    try {
      final response = await account.createEmailSession(
        email: email,
        password: password,
      );

      // Mendapatkan user ID dari atribut preferences
      final userIdFromPreferences = response.userId != null;

      if (userIdFromPreferences) {
        userIdToken.value = response.userId;
        Get.offAllNamed('/home');
        print('User signed in successfully');
      }
      return userIdFromPreferences;
    } catch (e) {
      print('Error during sign in: $e');
    }
    return false;
  }

  Future<void> signOut() async {
    try {
      await account.deleteSession(sessionId: 'current');
      userIdToken.value = '';
      Get.offAllNamed('/login');
      print('User signed out successfully');
    } catch (e) {
      print('Error during sign out: $e');
    }
  }
}
