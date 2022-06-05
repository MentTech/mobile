import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';

class ErrorNameWidget extends StatelessWidget {
  const ErrorNameWidget({
    Key? key,
    required this.textErrorName,
  }) : super(key: key);

  final String textErrorName;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      alignment: Alignment.center,
      child: Text(
        textErrorName,
        style: const TextStyle(
          fontSize: Dimens.medium_text,
          color: Colors.white,
        ),
      ),
    );
  }
}
