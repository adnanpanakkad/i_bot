import 'package:flutter/material.dart';
import 'package:i_bot/widget/constent/colors.dart';
import 'package:i_bot/widget/ui/custom_textstyle.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    this.validation,
    this.suffixIcon,
    this.keyboardType,
    this.readOnly,
    this.onChanged,
    this.focusNode,
  });
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String hintText;
  final FormFieldValidator? validation;
  final bool? readOnly;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      focusNode: focusNode,
      onChanged: onChanged,
      readOnly: readOnly ?? false,
      keyboardType: keyboardType,
      validator: validation,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        contentPadding: const EdgeInsets.all(20),
        hintText: hintText,
        hintStyle: CustomTextStyle.textFieldstyle,
        fillColor: Colors.grey.shade800,
        filled: true,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 210, 210, 210),
          ),
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
