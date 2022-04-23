import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final IconData? icon;
  final String? hint;
  final String? errorText;
  final bool isObscure;
  final bool isIcon;
  final TextInputType? inputType;
  final TextEditingController textController;
  final EdgeInsets padding;
  final Color hintColor;
  final Color iconColor;
  final FocusNode? focusNode;
  final ValueChanged? onFieldSubmitted;
  final ValueChanged? onChanged;
  final bool autoFocus;
  final TextInputAction? inputAction;
  final InputDecoration? inputDecoration;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        controller: textController,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        autofocus: autoFocus,
        textInputAction: inputAction,
        obscureText: isObscure,
        maxLength: 25,
        keyboardType: inputType,
        style: textStyle ?? Theme.of(context).textTheme.bodyText1,
        decoration: inputDecoration ??
            InputDecoration(
                hintText: hint,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: hintColor),
                errorText: errorText,
                counterText: '',
                icon: isIcon ? Icon(icon, color: iconColor) : null),
      ),
    );
  }

  const TextFieldWidget({
    Key? key,
    this.icon,
    this.errorText,
    required this.textController,
    this.inputType,
    this.hint,
    this.isObscure = false,
    this.isIcon = true,
    this.padding = const EdgeInsets.all(0),
    this.hintColor = Colors.white70,
    this.iconColor = Colors.grey,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.autoFocus = false,
    this.inputAction,
    this.inputDecoration,
    this.textStyle,
  }) : super(key: key);
}
