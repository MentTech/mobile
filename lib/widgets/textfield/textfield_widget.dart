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
  final FocusNode? focusNode;
  final ValueChanged? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final bool autoFocus;
  final TextInputAction? inputAction;
  final InputDecoration? inputDecoration;
  final TextStyle? textStyle;
  final int numberLines;
  final bool hasBorder;
  final Color? cursorColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextFormField(
        cursorColor:
            cursorColor ?? Theme.of(context).textSelectionTheme.cursorColor,
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
        style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
        decoration: inputDecoration ??
            InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: Dimens.horizontal_padding,
                vertical: Dimens.vertical_padding,
              ),
              enabledBorder: hasBorder
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).highlightColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        Dimens.kBorderMaxRadiusValue,
                      ),
                      gapPadding: 0,
                    )
                  : UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).highlightColor,
                      ),
                      borderRadius: Dimens.kBorderRadius,
                    ),
              focusedBorder: hasBorder
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).highlightColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        Dimens.kBorderMaxRadiusValue,
                      ),
                      gapPadding: 0,
                    )
                  : UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).highlightColor,
                        width: 3,
                      ),
                      borderRadius: Dimens.kBorderRadius,
                    ),
              focusColor: Theme.of(context).focusColor,
              hintText: hint,
              hintStyle: textStyle ??
                  Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).hintColor),
              errorText: errorText,
              counterText: '',
              icon: isIcon
                  ? IconTheme(
                      data: Theme.of(context).iconTheme,
                      child: SizedBox(child: icon ?? Icon(iconData)),
                    )
                  : null,
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
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.autoFocus = false,
    this.inputAction,
    this.inputDecoration,
    this.textStyle,
    this.numberLines = 1,
    this.hasBorder = false,
    this.cursorColor,
  }) : super(key: key);
}
