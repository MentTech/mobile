import 'package:flutter/material.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/effects/navigate/screen_transition.dart';
import 'package:mobile/ui/advanced_settings/advanced_settings.dart';
import 'package:mobile/ui/authorization/authorization_screen.dart';
import 'package:mobile/ui/home/home.dart';
import 'package:mobile/ui/password_changer/password_changer.dart';
import 'package:mobile/ui/program_register/program_register_screen.dart';
import 'package:mobile/ui/splash/splash.dart';
import 'package:mobile/ui/test_screen/test_screen.dart';
import 'package:mobile/ui/token_user_profile/balanced_profile.dart';
import 'package:mobile/ui/user_profile/user_profile.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String tokenProfile = '/token_profile';
  static const String programRegister = '/program_register';
  // static const String sessionDetail = '/session_detail';
  static const String advancedSettings = '/advanced_settings';
  static const String changePasswordSettings = '/change_password_settings';
  // static const String mentorProfile = '/mentor_profile';
  static const String testScreen = '/test_screen';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => const SplashScreen(),
    login: (BuildContext context) => const AuthorizationScreen(),
    home: (BuildContext context) => const HomeScreen(),
    profile: (BuildContext context) => const UserProfile(),
    tokenProfile: (BuildContext context) => const BalancedProfile(),
    programRegister: (BuildContext context) => ProgramRegisterScreen(),
    // sessionDetail: (BuildContext context) => SesstionDetail(),
    advancedSettings: (BuildContext context) => AdvancedSettings(),
    changePasswordSettings: (BuildContext context) =>
        const PasswordChangerScreen(),
    // mentorProfile: (BuildContext context) => const MentorProfile(),
    testScreen: (BuildContext context) => const TestScreen(),
  };

  ///
  /// Navigator.maybePop(context);
  ///
  static void popRoute(BuildContext context) => Navigator.maybePop(context);

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
  static void unauthenticatedRoute(BuildContext context) {
    Navigator.pushReplacement(
        context,
        CustomFadeTransitionPageRoute(
            timeCast: Properties.delayTimeInSecond,
            child: const AuthorizationScreen()));
  }

  ///
  /// easy way to navigate with Replacment
  ///
  static void navigatorReplacementSupporter(
      BuildContext context, String routeString) {
    Navigator.of(context).pushReplacementNamed(routeString);
  }

  ///
  /// easy way to navigate with adding stack
  ///
  static void navigatorSupporter(BuildContext context, String routeString) {
    Navigator.of(context).pushNamed(routeString);
  }

  ///
  /// Navigator.of(context).pushReplacementNamed(Routes.login);
  ///
  static void routeReplacement<T>(BuildContext context, Widget stateNavigate) {
    Navigator.pushReplacement(
      context,
      CustomFadeTransitionPageRoute(
        timeCast: Properties.delayTimeInSecond,
        child: stateNavigate,
      ),
    );
  }

  ///
  /// Navigator.of(context).push(Routes.login);
  ///
  static void route<T>(BuildContext context, Widget stateNavigate) {
    Navigator.push(
      context,
      CustomFadeTransitionPageRoute(
        timeCast: Properties.delayTimeInSecond,
        child: stateNavigate,
      ),
    );
  }
}
