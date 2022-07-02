import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/widgets/textfield/textfield_widget.dart';

class TextFieldNameWidget extends StatelessWidget {
  const TextFieldNameWidget({
    Key? key,
    required this.labelText,
    required this.errorText,
    required this.controller,
    required this.textColor,
    required this.onValueChanged,
    this.frontFlex = 5,
    this.backFlex = 15,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  final String labelText;
  final String? errorText;
  final Color textColor;
  final TextEditingController controller;
  final TextInputType textInputType;
  final ValueChanged<String> onValueChanged;

  final int frontFlex;
  final int backFlex;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      margin: const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: frontFlex,
            child: Text(
              labelText,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: textColor),
            ),
          ),
          Expanded(
            flex: backFlex,
            child: TextFieldWidget(
              hint: labelText,
              isIcon: false,
              inputType: textInputType,
              textController: controller,
              inputAction: TextInputAction.done,
              autoFocus: false,
              onChanged: onValueChanged,
              errorText: errorText,
            ),
          ),
        ],
      ),
    );
  }
}
