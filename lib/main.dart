import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile/ui/my_app.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'di/components/service_locator.dart';
import 'utils/device/device_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await setPreferredOrientations();
  await setupLocator();

  await PackageInfo.fromPlatform().then((packageInfo) {
    DeviceUtils.packageInfo = packageInfo;
  });
  return runZonedGuarded(() async {
    runApp(MyApp());
  }, (error, stack) {
    log(stack.toString());
    log(error.toString());
  });
}

// Future<void> setPreferredOrientations() {
//   return SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//     DeviceOrientation.landscapeRight,
//     DeviceOrientation.landscapeLeft,
//   ]);
// }
