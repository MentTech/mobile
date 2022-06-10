import 'package:flutter/material.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';

class DialogPopupPresenter {
  static Future<T?> showSlidePopupDialog<T>(
    BuildContext context,
    Widget child,
    double height,
    double width, {
    double blur = Properties.blur_glass_morphism,
    double opacity = Properties.opacity_glass_morphism,
  }) async {
    return showGeneralDialog(
      context: context,
      barrierLabel: "Reviews",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) {
        return Center(
          child: SizedBox(
            height: height,
            width: width,
            child: GlassmorphismContainer(
              child: child,
              blur: blur,
              opacity: opacity,
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
      useRootNavigator: true,
    );
  }
}
