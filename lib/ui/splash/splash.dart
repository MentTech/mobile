import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/constants/strings.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/authen/authen_store.dart';
import 'package:mobile/stores/search_store.dart/search_store.dart';
import 'package:mobile/stores/theme/theme_store.dart';
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
  // stores:--------------------------------------------------------------------
  UserStore? userStore;
  final ThemeStore _themeStore = getIt<ThemeStore>();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    userStore = Provider.of<UserStore>(context, listen: false);
    userStore!.callback = (result) {
      if (result) {
        Provider.of<SearchStore>(context, listen: false)
            .initializeDatabase()
            .then(
          (_) {
            Routes.authenticatedRoute(context);
          },
        );
      } else {
        Routes.unauthenticatedRoute(context);
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
          child: Hero(
        tag: Strings.authorizeHeroTag,
        child: AppIconWidget(image: _themeStore.appIcon),
      )),
    );
  }

  startTimer() {
    var _duration =
        const Duration(milliseconds: Properties.delayTimeInMiliSecond);
    return Timer(_duration, fetch);
  }

  void fetch() async {
    final AuthenStore auth = getIt<AuthenStore>();

    await PackageInfo.fromPlatform().then((packageInfo) {
      DeviceUtils.packageInfo = packageInfo;
    });

    if (auth.canBeAuthenticated) {
      // asynchronous
      userStore!.fetchUserInfor();
    } else {
      Routes.unauthenticatedRoute(context);
    }
  }
}
