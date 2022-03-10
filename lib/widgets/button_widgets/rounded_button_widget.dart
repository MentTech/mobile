import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  const RoundedButtonWidget({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    this.textColor = Colors.white,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: Dimens.vertical_padding / 2,
            horizontal: Dimens.horizontal_padding),
        decoration: ShapeDecoration(
          color: buttonColor,
          shape: StadiumBorder(
              side:
                  BorderSide(color: Colors.white.withOpacity(0.2), width: 1.5)),
        ),
        child: Text(
          buttonText,
          style: Theme.of(context).textTheme.button!.copyWith(color: textColor),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
