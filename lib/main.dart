import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/routes/app_pages.dart';
import 'package:noteapp/controller/image.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
  Get.put(ImagePickerController());
}