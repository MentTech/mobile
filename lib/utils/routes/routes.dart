import 'package:flutter/material.dart';
import 'package:mobile/ui/authorization/authorization_screen.dart';
import 'package:mobile/ui/home/home.dart';
import 'package:mobile/ui/splash/splash.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => const SplashScreen(),
    login: (BuildContext context) => const AuthorizationScreen(),
    home: (BuildContext context) => const HomeScreen(),
  };
}
