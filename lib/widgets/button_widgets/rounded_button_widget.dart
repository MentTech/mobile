import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final VoidCallback onPressed;
  final EdgeInsets padding;

  const RoundedButtonWidget({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    this.textColor,
    this.borderColor,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(
        vertical: Dimens.vertical_padding,
        horizontal: Dimens.horizontal_padding),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: ShapeDecoration(
        color: buttonColor,
        shape: StadiumBorder(
            side: BorderSide(
                color: borderColor ??
                    textColor?.withOpacity(0.5) ??
                    Theme.of(context).highlightColor,
                width: 1.5)),
      ),
      child: InkWell(
        child: Container(
          padding: padding,
          decoration: ShapeDecoration(
            color: buttonColor,
            shape: StadiumBorder(
              side: BorderSide(
                  color: borderColor ??
                      textColor?.withOpacity(0.5) ??
                      Theme.of(context).dividerColor,
                  width: 1.5),
            ),
          ),
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: textColor == null
                ? Theme.of(context).textTheme.bodyMedium
                : Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: textColor),
          ),
        ),
        onTap: onPressed,
      ),
    );
  }
}
