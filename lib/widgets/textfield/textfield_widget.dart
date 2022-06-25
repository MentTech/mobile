import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';

class TextFieldWidget extends StatelessWidget {
  final Icon? icon;
  final IconData? iconData;
  final String? hint;
  final String? errorText;
  final bool isObscure;
  final bool isIcon;
  final TextInputType? inputType;
  final TextEditingController textController;
  final EdgeInsets margin;
  final Color hintColor;
  final Color iconColor;
  final FocusNode? focusNode;
  final ValueChanged? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final bool autoFocus;
  final TextInputAction? inputAction;
  final InputDecoration? inputDecoration;
  final TextStyle? textStyle;
  final int numberLines;
  final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextFormField(
        cursorColor: hintColor,
        controller: textController,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        autofocus: autoFocus,
        textInputAction: inputAction,
        obscureText: isObscure,
        minLines: numberLines,
        maxLines: numberLines,
        keyboardType: inputType,
        style: textStyle ?? Theme.of(context).textTheme.bodyText1,
        decoration: inputDecoration ??
            InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: Dimens.horizontal_padding,
                vertical: Dimens.vertical_padding,
              ),
              enabledBorder: hasBorder
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: hintColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        Dimens.kBorderMaxRadiusValue,
                      ),
                      gapPadding: 0,
                    )
                  : UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: hintColor,
                      ),
                      borderRadius: Dimens.kBorderRadius,
                    ),
              focusedBorder: hasBorder
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: hintColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        Dimens.kBorderMaxRadiusValue,
                      ),
                      gapPadding: 0,
                    )
                  : UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: hintColor,
                        width: 3,
                      ),
                      borderRadius: Dimens.kBorderRadius,
                    ),
              focusColor: hintColor,
              hintText: hint,
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: hintColor),
              errorText: errorText,
              counterText: '',
              icon: icon ?? (isIcon ? Icon(iconData, color: iconColor) : null),
            ),
      ),
    );
  }

  const TextFieldWidget({
    Key? key,
    this.icon,
    this.iconData,
    this.errorText,
    required this.textController,
    this.inputType,
    this.hint,
    this.isObscure = false,
    this.isIcon = true,
    this.margin = EdgeInsets.zero,
    this.hintColor = Colors.white70,
    this.iconColor = Colors.grey,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.autoFocus = false,
    this.inputAction,
    this.inputDecoration,
    this.textStyle,
    this.numberLines = 1,
    this.hasBorder = false,
  }) : super(key: key);
}
