import 'package:flutter/material.dart';
import 'package:news/core/utils/app_colors.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String label;
  final Widget? suffix;
  final String? Function(String?)? validator;
  const InputWidget({
    super.key,
    required this.controller,
    this.obscureText = false,
    required this.label,
    this.suffix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColors.grey,
      style: TextStyle(
        color: AppColors.black,
        fontFamily: "SFPro",
        fontWeight: FontWeight.w500,
      ),
      obscureText: obscureText,

      obscuringCharacter: "*",
      decoration: InputDecoration(
        label: Text(
          label,
          style: TextStyle(
            color: AppColors.grey,
            fontFamily: "SFPro",
            fontWeight: FontWeight.w500,
          ),
        ),
        suffixIcon: suffix,

        border: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey),
        ),
      ),
      validator: validator,
    );
  }
}
