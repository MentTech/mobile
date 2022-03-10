import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/constants/assets.dart';
import 'package:mobile/constants/numbers.dart';
import 'package:mobile/effects/navigate/screen_transition.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:mobile/ui/home/home.dart';
import 'package:mobile/utils/routes/routes.dart';
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
      child: Center(child: AppIconWidget(image: Assets.appLogo)),
    );
  }

  startTimer() {
    var _duration = const Duration(milliseconds: Numbers.delayTimeInMiliSecond);
    return Timer(_duration, navigate);
  }

  navigate() async {
    final UserStore userAuth = Provider.of<UserStore>(context, listen: false);

    if (userAuth.accessToken != null) {
      // Navigator.of(context).pushReplacementNamed(Routes.home);
      Navigator.pushReplacement(
          context,
          CustomFadeTransitionPageRoute(
              timeCast: Numbers.delayTimeInSecond, child: const HomeScreen()));
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.login);
    }
  }
}
