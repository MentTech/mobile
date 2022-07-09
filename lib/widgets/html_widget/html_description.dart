import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mobile/constants/dimens.dart';

class HtmlDesciption extends StatelessWidget {
  const HtmlDesciption({
    Key? key,
    required this.data,
  }) : super(key: key);

  final String? data;

  @override
  Widget build(BuildContext context) {
    return Html(
      data: data,
      shrinkWrap: true,
      style: {
        "li": Style(
          color: Theme.of(context).indicatorColor,
          fontSize: const FontSize(Dimens.small_text),
        ),
        "p": Style(
          color: Theme.of(context).indicatorColor,
          fontSize: const FontSize(Dimens.small_text),
        ),
        "span": Style(
          color: Theme.of(context).indicatorColor,
          fontSize: const FontSize(Dimens.small_text),
        ),
      },
    );
  }
}
