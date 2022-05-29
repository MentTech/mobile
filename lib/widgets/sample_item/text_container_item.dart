import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';

class TextContainerExample extends StatelessWidget {
  const TextContainerExample({
    Key? key,
    required this.title,
    required this.contend,
  }) : super(key: key);

  final String title;
  final String contend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.horizontal_padding,
        vertical: Dimens.vertical_padding,
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              height: 1.2,
              fontSize: Dimens.medium_text,
            ),
          ),
          const SizedBox(
            height: Dimens.vertical_margin,
          ),
          Text(
            contend,
            style: const TextStyle(
              height: 1.2,
              fontSize: Dimens.small_text,
            ),
          ),
        ],
      ),
    );
  }
}
