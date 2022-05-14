import 'package:flutter/material.dart';
import 'package:mobile/constants/colors.dart';
import 'package:mobile/constants/dimens.dart';

class LinearNamedListWidget extends StatelessWidget {
  const LinearNamedListWidget({
    Key? key,
    required this.children,
    required this.namedContainer,
    this.marginPerChild =
        const EdgeInsets.symmetric(vertical: Dimens.small_vertical_margin),
    this.margin = EdgeInsets.zero,
    this.themeColor = AppColors.lightTextTheme,
  }) : super(key: key);

  final List<Widget> children;
  final EdgeInsets marginPerChild;
  final EdgeInsets margin;
  final String namedContainer;
  final Color themeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            namedContainer,
            style: TextStyle(
              fontSize: Dimens.medium_text,
              fontWeight: FontWeight.w600,
              color: themeColor,
            ),
          ),
          const SizedBox(
            height: Dimens.vertical_margin,
          ),
          for (Widget item in children)
            Container(
              margin: marginPerChild,
              child: item,
            )
        ],
      ),
    );
  }
}
