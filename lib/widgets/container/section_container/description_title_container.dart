import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';

class DescriptionTitleContainer extends StatelessWidget {
  const DescriptionTitleContainer({
    Key? key,
    required this.titleWidget,
    required this.contentWidget,
    this.padding,
    this.spaceBetween = Dimens.vertical_margin,
  }) : super(key: key);

  final EdgeInsets? padding;
  final double spaceBetween;
  final Widget titleWidget;
  final Widget contentWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleWidget,
          SizedBox(
            height: spaceBetween,
          ),
          contentWidget,
        ],
      ),
    );
  }
}
