import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/controller/datacontroller.dart';
import 'package:noteapp/routes/app_pages.dart';
import 'package:noteapp/controller/image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
  Get.put(ImagePickerController());
  Get.put(NoteController());
}
