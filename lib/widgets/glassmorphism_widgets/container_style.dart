import 'dart:ui';

import 'package:flutter/material.dart';

class GlassmorphismContainer extends StatelessWidget {
  const GlassmorphismContainer({
    Key? key,
    required this.child,
    required this.blur,
    required this.opacity,
    this.radius = 20,
    this.padding = const EdgeInsets.all(0),
  }) : super(key: key);

  final double blur;
  final double opacity;
  final double radius;
  final EdgeInsets padding;
  final Widget child;

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
          padding: padding,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(opacity),
              border: Border.all(
                width: 1.5,
                color: Colors.white.withOpacity(opacity),
              )),
          child: child,
        ),
      ),
    );
  }
}
