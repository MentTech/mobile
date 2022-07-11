import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/widgets/button_widgets/rounded_button_widget.dart';

class YesNoPopup extends StatelessWidget {
  const YesNoPopup({
    Key? key,
    required this.child,
    this.agreeText = "Yes",
    this.disagreeText = "No",
    this.textAgreeColor = Colors.green,
    this.textDisagreeColor = Colors.red,
  }) : super(key: key);

  final Widget child;

  final String agreeText;
  final String disagreeText;

  final Color textAgreeColor;
  final Color textDisagreeColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.large_horizontal_padding,
          vertical: Dimens.vertical_padding,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: child,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RoundedButtonWidget(
                  buttonText: agreeText,
                  buttonColor: Colors.transparent,
                  textColor: textAgreeColor,
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimens.small_vertical_padding,
                      horizontal: Dimens.horizontal_padding),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(true);
                  },
                ),
                const SizedBox(
                  width: Dimens.lightly_medium_vertical_margin,
                ),
                RoundedButtonWidget(
                  buttonText: disagreeText,
                  buttonColor: Colors.transparent,
                  textColor: textDisagreeColor,
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimens.small_vertical_padding,
                      horizontal: Dimens.horizontal_padding),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(false);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
