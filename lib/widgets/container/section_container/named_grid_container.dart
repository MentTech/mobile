import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';

class NamedGridContainer extends StatelessWidget {
  const NamedGridContainer({
    Key? key,
    required this.children,
    required this.crossAxisCount,
    this.margin = const EdgeInsets.all(Dimens.horizontal_margin),
    this.crossAxisSpacing = 10.0,
    this.mainAxisSpacing = 10.0,
  }) : super(key: key);

  final List<Widget> children;
  final int crossAxisCount;
  final EdgeInsets margin;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: GridView.count(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        // children: children,
      ),
    );
  }
}
