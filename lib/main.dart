import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/controller/authcontroller.dart';
import 'package:noteapp/controller/notifcontroller.dart';
import 'package:noteapp/routes/app_pages.dart';
import 'package:noteapp/controller/image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Get.putAsync(() async => await SharedPreferences.getInstance());
  await FirebaseMessagingHandler().initPushNotification();
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
}


