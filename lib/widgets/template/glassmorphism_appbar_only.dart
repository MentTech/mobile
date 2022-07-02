import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/widgets/appbar/custom_appbar_in_stack.dart';
import 'package:mobile/widgets/background_colorful/linear_gradient_background.dart';

class GlassmorphismGradientScaffoldAppbar extends StatelessWidget {
  const GlassmorphismGradientScaffoldAppbar({
    Key? key,
    required this.appbarName,
    required this.child,
    this.safeAreaTop = false,
    this.safeAreaRight = false,
    this.safeAreaBottom = false,
    this.safeAreaLeft = false,
    this.messageNotification,
    this.progressIndicator,
  }) : super(key: key);

  final bool safeAreaTop;
  final bool safeAreaRight;
  final bool safeAreaBottom;
  final bool safeAreaLeft;

  final String appbarName;
  final Widget child;
  final Observer? messageNotification;
  final Observer? progressIndicator;

  @override
  Widget build(BuildContext context) {
    final ThemeStore themeStore = getIt<ThemeStore>();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          LinearGradientBackground(
            colors: themeStore.lineToLineGradientColors,
            stops: null,
          ),
          SafeArea(
            top: safeAreaTop,
            right: safeAreaRight,
            bottom: safeAreaBottom,
            left: safeAreaLeft,
            child: child,
          ),
          CustomInStackAppBar(
            nameAppbar: appbarName,
          ),
          messageNotification ?? const SizedBox(),
          progressIndicator ?? const SizedBox(),
        ],
      ),
    );
  }
}
