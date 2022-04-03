import 'package:flutter/material.dart';
import 'package:mobile/constants/colors.dart';
import 'package:mobile/constants/dimens.dart';

class LinearNamedWidgetList extends StatelessWidget {
  const LinearNamedWidgetList({
    Key? key,
    required this.children,
    required this.crossAxisCount,
    required this.namedContainer,
    this.margin =
        const EdgeInsets.symmetric(vertical: Dimens.horizontal_margin / 2),
    this.crossAxisSpacing = 10.0,
    this.mainAxisSpacing = 10.0,
  }) : super(key: key);

  final List<Widget> children;
  final int crossAxisCount;
  final EdgeInsets margin;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final String namedContainer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          namedContainer,
          style: const TextStyle(
              fontSize: Dimens.medium_text,
              fontWeight: FontWeight.w600,
              color: AppColors.lightTextTheme),
        ),
        const SizedBox(
          height: Dimens.vertical_margin,
        ),
        for (Widget item in children)
          Container(
            margin: margin,
            child: item,
          )
      ],
    );
  }
}
