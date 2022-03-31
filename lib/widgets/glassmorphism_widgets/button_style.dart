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
      colors: [Colors.blue, Colors.orange],
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
    return CustomPaint(
      painter: _GradientPainter(
          strokeWidth: 1.5, radius: radius, gradient: gradientBorder),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.white.withOpacity(0.3),
                blurRadius: 13,
                spreadRadius: 5,
                offset: const Offset(-4, -4)),
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 13,
                spreadRadius: 5,
                offset: const Offset(4, 4)),
          ],
        ),
        child: ClipRRect(
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
                    color: Colors.white.withOpacity(opacity),
                    border: Border.all(
                      width: 0,
                      color: Colors
                          .transparent, //Colors.white.withOpacity(opacity),
                    )),
                child: Text(text),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: unused_element
class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter({
    required this.strokeWidth,
    required this.radius,
    required this.gradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect =
        RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth,
        size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
