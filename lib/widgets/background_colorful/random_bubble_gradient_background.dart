import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile/utils/device/device_utils.dart';

// ignore: must_be_immutable
class RandomBubbleGradientBackground extends StatelessWidget {
  RandomBubbleGradientBackground({
    Key? key,
    required this.count,
    required this.maxRadius,
    required this.minRadius,
    required this.gradientColor,
  }) : super(key: key) {
    rng = Random(DateTime.now().millisecondsSinceEpoch);
  }

  final double maxRadius;
  final double minRadius;
  final List<Color> gradientColor;
  final int count;

  late final Random rng;

  List<Position> centers = [];

  double get nextDoubleRadiusRamdom => rng.nextDouble() * maxRadius + minRadius;

  double getNextDoubleHeightDeviceRamdom(BuildContext context) =>
      rng.nextDouble() * DeviceUtils.getScaledHeight(context, 1);

  double getNextDoubleWidthDeviceRamdom(BuildContext context) =>
      rng.nextDouble() * DeviceUtils.getScaledWidth(context, 1);

  @override
  Widget build(BuildContext context) {
    if (centers.isEmpty) {
      for (int i = 0; i < count; i++) {
        centers.add(Position(
          x: getNextDoubleWidthDeviceRamdom(context),
          y: getNextDoubleHeightDeviceRamdom(context),
        ));
      }
    }

    return Stack(
      children: <Widget>[
        for (final center in centers)
          Builder(
            builder: (context) {
              final double radiusRnd = nextDoubleRadiusRamdom;

              return Positioned(
                  left: center.x - radiusRnd,
                  top: center.y - radiusRnd,
                  child: Container(
                    height: radiusRnd * 2,
                    width: radiusRnd * 2,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: gradientColor.first.withOpacity(0.2),
                            blurRadius: 15,
                            offset: const Offset(2, -2),
                          ),
                          BoxShadow(
                            color: gradientColor.last.withOpacity(0.2),
                            blurRadius: 15,
                            offset: const Offset(-2, 2),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: gradientColor,
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        )),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white.withOpacity(0.0)),
                      ),
                    ),
                  ));
            },
          ),
      ],
    );
  }
}

class Position {
  final double x;
  final double y;

  Position({required this.x, required this.y});
}
