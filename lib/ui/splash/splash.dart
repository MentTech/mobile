import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/constants/assets.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/constants/strings.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/authen/authen_store.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:mobile/widgets/app_icon_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
    final AuthenStore auth = getIt<AuthenStore>();
    final UserStore userStore = Provider.of<UserStore>(context, listen: false);

    await PackageInfo.fromPlatform().then((packageInfo) {
      DeviceUtils.packageInfo = packageInfo;
    });

    if (auth.canBeAuthenticated) {
      userStore.accessToken = auth.accessToken;

      await userStore.fetchUserInfor().then((isAuthenticated) {
        if (isAuthenticated) {
          Routes.authenticatedRoute(context);
        } else {
          Routes.unauthenticatedRoute(context);
        }
      });
    } else {
      Routes.unauthenticatedRoute(context);
    }
  }
}
