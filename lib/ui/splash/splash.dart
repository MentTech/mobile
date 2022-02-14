import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/constants/assets.dart';
import 'package:mobile/data/sharedpref/constants/preferences.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:mobile/widgets/app_icon_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      child: Center(child: AppIconWidget(image: Assets.appLogo)),
    );
  }

  startTimer() {
    var _duration = const Duration(milliseconds: 2000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.getBool(Preferences.is_logged_in) ?? false) {
      Navigator.of(context).pushReplacementNamed(Routes.home);
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.login);
    }
  }
}
