import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';

class DescriptionTitleContainer extends StatelessWidget {
  const DescriptionTitleContainer({
    Key? key,
    required this.titleWidget,
    required this.contentWidget,
    this.padding,
    this.paddingTitle,
    this.spaceBetween = Dimens.vertical_margin,
  }) : super(key: key);

  final EdgeInsets? padding;
  final EdgeInsets? paddingTitle;
  final double spaceBetween;
  final Widget titleWidget;
  final Widget contentWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: paddingTitle ?? EdgeInsets.zero,
            child: titleWidget,
          ),
          SizedBox(
            height: spaceBetween,
          ),
          contentWidget,
        ],
      ),
    );
  }
}
