import 'dart:ui';

import 'package:flutter/material.dart';

class GlassmorphismContainer extends StatelessWidget {
  const GlassmorphismContainer({
    Key? key,
    required this.child,
    required this.blur,
    required this.opacity,
    this.radius = 20,
    this.padding = EdgeInsets.zero,
    this.background = Colors.white,
    this.border = Colors.white,
    this.height,
    this.width,
  }) : super(key: key);

  final double blur;
  final double opacity;
  final double radius;
  final EdgeInsets padding;
  final Widget child;

  final Color background;
  final Color border;

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blur,
          sigmaY: blur,
        ),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
              color: background.withOpacity(opacity),
              border: Border.all(
                width: 1.5,
                color: border.withOpacity(opacity),
              )),
          child: child,
        ),
      ),
    );
  }
}
