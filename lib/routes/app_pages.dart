// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:noteapp/views/edit.dart';
import 'package:noteapp/views/home.dart';
import 'package:noteapp/views/login.dart';
import 'package:noteapp/views/webview.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // Change INITIAL to point to the splash screen route
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: _Paths.EDIT,
      page: () => const EditScreen(),
    ),
    GetPage(
      name: _Paths.TUTORWEB,
      page: () => const TutorWebScreen(),
    )
  ];
}