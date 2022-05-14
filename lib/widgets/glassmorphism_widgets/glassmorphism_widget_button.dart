import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile/constants/colors.dart';
import 'package:mobile/constants/dimens.dart';

class GlassmorphismWidgetButton extends StatelessWidget {
  const GlassmorphismWidgetButton({
    Key? key,
    required this.child,
    required this.blur,
    required this.opacity,
    this.gradientBorder = const LinearGradient(
      colors: [
        Colors.blue,
        Colors.orange,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    this.radius = 20,
    this.width = 150,
    this.padding = const EdgeInsets.all(0),
    this.fontSizeText = Dimens.small_text,
    this.textColor = AppColors.lightTextTheme,
    this.alignment = Alignment.topLeft,
    this.onTap,
  }) : super(key: key);

  final double blur;
  final double opacity;
  final double radius;
  final double width;
  final EdgeInsets padding;
  final Widget child;
  final double fontSizeText;
  final Color textColor;
  final Gradient gradientBorder;
  final Alignment alignment;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blur,
          sigmaY: blur,
        ),
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: width,
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: Colors.white.withOpacity(opacity),
              border: Border.all(
                width: 1.5,
                color: Colors.white.withOpacity(opacity),
              ),
            ),
            child: Align(
              alignment: alignment,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
