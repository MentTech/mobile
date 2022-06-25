import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/widgets/button_widgets/rounded_button_widget.dart';
import 'package:mobile/widgets/textfield/textfield_widget.dart';

class FieldPopupTemplate extends StatefulWidget {
  const FieldPopupTemplate({
    Key? key,
    required this.title,
    required this.fieldContents,
    this.middleChild,
    this.agreeText = "Send",
    this.disagreeText = "Cancel",
    this.textAgreeColor = Colors.green,
    this.textDisagreeColor = Colors.red,
  }) : super(key: key);

  final String title;
  final List<TextFieldContent> fieldContents;

  final Widget? middleChild;

  final String agreeText;
  final String disagreeText;

  final Color textAgreeColor;
  final Color textDisagreeColor;

  @override
  State<FieldPopupTemplate> createState() => _FieldPopupTemplateState();
}

class _FieldPopupTemplateState extends State<FieldPopupTemplate> {
  // Store:---------------------------------------------------------------------
  final ThemeStore themeStore = getIt<ThemeStore>();

  // Controller:----------------------------------------------------------------
  final List<TextEditingController> controllers = [];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.horizontal_padding,
          vertical: Dimens.vertical_padding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: Dimens.vertical_margin,
              ),
              child: Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: Dimens.lightly_medium_text,
                ),
              ),
            ),
            const Divider(
              thickness: 1.1,
              color: Colors.white,
            ),
            widget.middleChild ?? const SizedBox(),
            ...widget.fieldContents
                .map((fieldContent) => _buildField(fieldContent))
                .toList(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RoundedButtonWidget(
                      buttonText: widget.agreeText,
                      buttonColor: Colors.transparent,
                      textColor: widget.textAgreeColor,
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop(true);
                      },
                    ),
                    RoundedButtonWidget(
                      buttonText: widget.disagreeText,
                      buttonColor: Colors.transparent,
                      textColor: widget.textDisagreeColor,
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop(false);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(TextFieldContent textFieldContent) {
    return Container(
      alignment: Alignment.center,
      child: TextFieldWidget(
        hint: textFieldContent.hint,
        inputType: textFieldContent.textInputType,
        iconData: textFieldContent.iconData,
        isObscure: textFieldContent.isObscure,
        iconColor: themeStore.reverseThemeColor,
        textController: textFieldContent.textEditingController,
        inputAction: TextInputAction.done,
        autoFocus: false,
        onChanged: textFieldContent.valueChangedCallback,
        errorText: textFieldContent.errorText,
        hintColor: Colors.white70,
        numberLines: textFieldContent.numberLines,
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: Dimens.small_text,
        ),
      ),
    );
  }
}

class TextFieldContent {
  final IconData? iconData;
  final bool isObscure;
  final String? hint;
  final TextEditingController textEditingController;
  final String? errorText;
  final ValueChanged<String>? valueChangedCallback;
  final TextInputType textInputType;
  final int numberLines;

  TextFieldContent({
    this.iconData,
    required this.isObscure,
    this.hint,
    required this.textEditingController,
    this.errorText,
    this.valueChangedCallback,
    this.textInputType = TextInputType.text,
    this.numberLines = 1,
  });
}
