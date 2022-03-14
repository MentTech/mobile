import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/constants/assets.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/constants/strings.dart';
import 'package:mobile/effects/navigate/screen_transition.dart';
import 'package:mobile/stores/authen/authen_store.dart';
import 'package:mobile/ui/authorization/authorization_screen.dart';
import 'package:mobile/ui/home/home.dart';
import 'package:mobile/widgets/app_icon_widget.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
          child: Hero(
        tag: Strings.authorizeHeroTag,
        child: AppIconWidget(image: Assets.appLogo),
      )),
    );
  }

  startTimer() {
    var _duration =
        const Duration(milliseconds: Properties.delayTimeInMiliSecond);
    return Timer(_duration, navigate);
  }

  navigate() async {
    final AuthenStore auth = Provider.of<AuthenStore>(context, listen: false);

    if (auth.accessToken != null) {
      // Navigator.of(context).pushReplacementNamed(Routes.home);
      Navigator.pushReplacement(
          context,
          CustomFadeTransitionPageRoute(
              timeCast: Properties.delayTimeInSecond,
              child: const HomeScreen()));
    } else {
      // Navigator.of(context).pushReplacementNamed(Routes.login);
      Navigator.pushReplacement(
          context,
          CustomFadeTransitionPageRoute(
              timeCast: Properties.delayTimeInSecond,
              child: const AuthorizationScreen()));
    }
  }
}
