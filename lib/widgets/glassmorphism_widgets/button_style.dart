import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile/constants/colors.dart';
import 'package:mobile/constants/dimens.dart';

class GlassmorphismButton extends StatelessWidget {
  const GlassmorphismButton({
    Key? key,
    required this.text,
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
    this.padding = const EdgeInsets.all(0),
    this.fontSizeText = Dimens.small_text,
    this.textColor = AppColors.lightTextTheme,
    this.onTap,
  }) : super(key: key);

  final double blur;
  final double opacity;
  final double radius;
  final EdgeInsets padding;
  final String text;
  final double fontSizeText;
  final Color textColor;
  final Gradient gradientBorder;
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
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: Colors.white.withOpacity(opacity),
              border: Border.all(
                width: 1.5,
                color: Colors.white.withOpacity(opacity),
              ),
            ),
            child: Text(text,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: textColor,
                    letterSpacing: 0.2,
                    fontSize: Dimens.small_text)),
          ),
        ),
      ),
    );
  }
}
