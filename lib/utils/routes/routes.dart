import 'package:flutter/material.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/effects/navigate/screen_transition.dart';
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

  ///
  /// Navigator.of(context).pushReplacementNamed(Routes.home);
  ///
  static void authenticatedRoute(
          BuildContext context) =>
      Navigator.pushReplacement(
          context,
          CustomFadeTransitionPageRoute(
              timeCast: Properties.delayTimeInSecond,
              child: const HomeScreen()));

  ///
  /// Navigator.of(context).pushReplacementNamed(Routes.login);
  ///
  static void unauthenticatedRoute(BuildContext context) =>
      Navigator.pushReplacement(
          context,
          CustomFadeTransitionPageRoute(
              timeCast: Properties.delayTimeInSecond,
              child: const AuthorizationScreen()));
}
