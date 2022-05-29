import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';

class StarRateWidget extends StatelessWidget {
  const StarRateWidget({
    Key? key,
    this.rateColor = Colors.yellow,
    this.textColor = Colors.white,
    this.sizeStar = Dimens.medium_text,
    this.sizeText = Dimens.small_text,
    this.rating = 0.0,
    this.count = 0,
  }) : super(key: key);

  final Color rateColor;
  final Color textColor;

  final double sizeStar;
  final double sizeText;

  final double rating;

  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.star_rate_rounded,
          color: rateColor,
          size: sizeStar,
        ),
        Text(
          " $rating" + (count != 0 ? "($count reviews)" : ""),
          style: TextStyle(
            color: Colors.white,
            fontSize: sizeText,
          ),
        ),
      ],
    );
  }
}
