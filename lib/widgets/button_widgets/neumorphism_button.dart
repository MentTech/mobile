import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';

class NeumorphismButton extends StatelessWidget {
  const NeumorphismButton({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(5),
    this.backgroundColor = const Color(0xFF7A7991),
    this.borderRadius = Dimens.kBorderRadiusValue,
    this.shape = BoxShape.rectangle,
    this.onTap,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets padding;
  final Color backgroundColor;
  final double borderRadius;
  final BoxShape shape;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
          child: Container(
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
            child: child,
          ),
        ),
        padding: padding,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: shape != BoxShape.circle
                ? BorderRadius.circular(borderRadius)
                : null,
            shape: shape,
            boxShadow: [
              BoxShadow(
                color: Color.alphaBlend(
                    backgroundColor.withOpacity(0.4), Colors.white60),
                offset: const Offset(-5, -5),
                blurRadius: 10,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Color.alphaBlend(backgroundColor, Colors.grey.shade700),
                offset: const Offset(5, 5),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ]),
      ),
    );
  }
}
