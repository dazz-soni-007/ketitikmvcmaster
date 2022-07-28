// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:ketitik/screens/auth/binding/auth_binding.dart';
import 'package:ketitik/screens/auth/binding/login_binding.dart';
import 'package:ketitik/screens/bookmark/binding/bookmarkbinding.dart';
import 'package:ketitik/screens/bookmark/bookmarklist.dart';
import 'package:ketitik/screens/homescreen/binding/home_binding.dart';
import 'package:ketitik/screens/homescreen/view/home_screen.dart';
import 'package:ketitik/screens/prefrences/views/prefrence_screen.dart';
import 'package:ketitik/screens/splash/views/splash_screen.dart';

import '../screens/auth/views/login_screen.dart';
import '../screens/auth/views/register_screen.dart';
import '../screens/prefrences/views/prefrence_screen.dart';

class AppRoute {
  AppRoute._();

  static final routes = [
    GetPage(
        name: RoutingNameConstants.SPLASH_SCREEN_ROUTE,
        page: () => const SplashScreen(),
        binding: AuthBinding()),
    GetPage(
        name: RoutingNameConstants.LOGIN_SCREEN_ROUTE,
        page: () => const LoginScreen(),
        binding: LoginBinding()),
    GetPage(
        name: RoutingNameConstants.HOME_SCREEN_ROUTE,
        page: () => MyHomePage.withA(),
        binding: HomeBinding()),
    GetPage(
      name: RoutingNameConstants.REGISTER_SCREEN_ROUTE,
      page: () => RegisterScreen(),
    ),
    GetPage(
      name: RoutingNameConstants.PREFERENCE_SCREEN_ROUTE,
      page: () => PrefrenceScreen(),
    ),
    GetPage(
      name: RoutingNameConstants.BOOKMARK_SCREEN_ROUTE,
      page: () => BookMarkPage(),
      binding: BookMarkBinding(),
    ),
  ];
}

class RoutingNameConstants {
  static String SPLASH_SCREEN_ROUTE = "/splash_screen";
  static String LOGIN_SCREEN_ROUTE = "/login_screen";
  static String REGISTER_SCREEN_ROUTE = "/register_screen";
  static String HOME_SCREEN_ROUTE = "/home_screen";

  static String PREFERENCE_SCREEN_ROUTE = "/preference_screen";
  static String BOOKMARK_SCREEN_ROUTE = "/bookmark_screen";
}
