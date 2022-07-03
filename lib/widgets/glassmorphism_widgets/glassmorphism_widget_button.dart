import 'dart:ui';

import 'package:flutter/material.dart';

class GlassmorphismWidgetButton extends StatelessWidget {
  const GlassmorphismWidgetButton({
    Key? key,
    required this.child,
    required this.blur,
    required this.opacity,
    this.background = Colors.white,
    this.border = Colors.white,
    this.radius = 20,
    this.width = 150,
    this.padding = const EdgeInsets.all(0),
    this.alignment,
    this.onTap,
  }) : super(key: key);

  final double blur;
  final double opacity;
  final double radius;
  final double? width;
  final EdgeInsets padding;
  final Widget child;
  final Color background;
  final Color border;
  final Alignment? alignment;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
      child: InkWell(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: blur,
              sigmaY: blur,
            ),
            child: Container(
              alignment: alignment,
              width: width,
              padding: padding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: background.withOpacity(opacity),
                border: Border.all(
                  width: 1.5,
                  color: border.withOpacity(opacity),
                ),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
