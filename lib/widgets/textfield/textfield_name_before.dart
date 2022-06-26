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
  }) : super(key: key);

  final String labelText;
  final String? errorText;
  final Color textColor;
  final TextEditingController controller;
  final ValueChanged<String> onValueChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      margin: const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              labelText,
              style: TextStyle(
                color: textColor,
                fontSize: Dimens.small_text,
              ),
            ),
          ),
          Expanded(
            flex: 15,
            child: TextFieldWidget(
              hint: labelText,
              textStyle: TextStyle(
                color: textColor,
                fontSize: Dimens.small_text,
              ),
              isIcon: false,
              inputType: TextInputType.emailAddress,
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
