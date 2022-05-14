import 'package:flutter/material.dart';
import 'package:mobile/constants/colors.dart';
import 'package:mobile/constants/dimens.dart';

class GridNamedListWidget extends StatelessWidget {
  const GridNamedListWidget({
    Key? key,
    required this.namedContainer,
    required this.children,
    required this.crossAxisCount,
    this.margin = const EdgeInsets.all(Dimens.horizontal_margin),
    this.crossAxisSpacing = 10.0,
    this.mainAxisSpacing = 10.0,
    this.themeColor = AppColors.lightTextTheme,
  }) : super(key: key);

  final List<Widget> children;
  final int crossAxisCount;
  final EdgeInsets margin;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final String namedContainer;
  final Color themeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
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
          GridView.count(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            children: children,
          ),
        ],
      ),
    );
  }
}
