import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/controller/appwritecontroller.dart';
import 'package:noteapp/controller/authcontroller.dart';
import 'package:noteapp/controller/notifcontroller.dart';
import 'package:noteapp/firebase_options.dart';
import 'package:noteapp/routes/app_pages.dart';
import 'package:noteapp/controller/image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appwrite/appwrite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Get.putAsync(() async => await SharedPreferences.getInstance());

  Client client = Client();
  client
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject('65631c1398656071fe82')
      .setSelfSigned(
          status:
              true); // For self signed certificates, only use for development
  await FirebaseMessagingHandler().initPushNotification();
  await FirebaseMessagingHandler().initLocalNotification();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );

  Get.put(ImagePickerController());
  Get.put(AuthsController());
  Get.put(AppWriteAuthController());
}
