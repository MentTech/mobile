import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';

class WrapNamedListWidget extends StatelessWidget {
  const WrapNamedListWidget({
    Key? key,
    required this.namedContainer,
    required this.children,
    this.direction = Axis.horizontal,
    this.margin = const EdgeInsets.all(Dimens.horizontal_margin),
    this.crossAxisSpacing = 10.0,
    this.mainAxisSpacing = 10.0,
    this.themeColor,
  }) : super(key: key);

  final List<Widget> children;
  final Axis direction;
  final EdgeInsets margin;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final String namedContainer;
  final Color? themeColor;

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
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: themeColor,
                ),
          ),
          const SizedBox(
            height: Dimens.vertical_margin,
          ),
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            spacing: mainAxisSpacing,
            runSpacing: crossAxisSpacing,
            direction: direction,
            children: children,
          ),
        ],
      ),
    );
  }
}
