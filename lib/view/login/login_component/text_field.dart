import 'package:flutter/material.dart';
import 'package:social_hub/res/color.dart';

class TextFieldSignIn extends StatelessWidget {
  const TextFieldSignIn({Key? key,
  required this.myController,
  required this.focusNode,
  required this.formFieldSetter,
  required this.formFieldValidator,
  required this.textInputType,
  required this.hint,
  required this.obscureText,
    this.autoFocus = true,
    this.enable = false,
  }) : super(key: key);

  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter formFieldSetter;
  final FormFieldValidator formFieldValidator;
  final TextInputType textInputType;
  final String hint;
  final bool obscureText;
  final bool enable, autoFocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      focusNode: focusNode,
      obscureText: obscureText,
      onFieldSubmitted: formFieldSetter,
      validator: formFieldValidator,
      keyboardType: textInputType,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 0.0),
      enabled: enable,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 0.0),
        contentPadding: const EdgeInsets.all(15.00),
        border:  const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textFieldDefaultBorderColor),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.alertColor),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textFieldDefaultBorderColor),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),

    );
  }
}
