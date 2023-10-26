import 'package:get/get.dart';
import 'package:noteapp/views/home.dart';
import 'package:noteapp/views/login.dart'; // Add this import

part 'app_routes.dart';
class AppPages {
  AppPages._();

  // Change INITIAL to point to the login route
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
  ];
}

// ...
