import 'package:flutter/material.dart';
import 'package:mobile/constants/colors.dart';

class LinearGradientBackground extends StatelessWidget {
  const LinearGradientBackground({
    Key? key,
    this.colors = const [
      AppColors.darkBlueContrast,
      AppColors.darkTextTheme,
    ],
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
    this.stops = const [0, 1],
  }) : super(key: key);

  final Alignment begin;
  final Alignment end;

  final List<Color> colors;
  final List<double> stops;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: begin,
          end: end,
          stops: stops,
        ),
      ),
    );
  }
}
