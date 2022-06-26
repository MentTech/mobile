import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';

class SmallTextWidget extends StatelessWidget {
  const SmallTextWidget({
    Key? key,
    required this.text,
    this.padding =
        const EdgeInsets.symmetric(vertical: Dimens.vertical_padding / 2),
  }) : super(key: key);

  final String text;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
