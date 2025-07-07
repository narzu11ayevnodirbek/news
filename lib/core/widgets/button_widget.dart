import 'package:flutter/material.dart';
import 'package:news/core/utils/app_colors.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  const ButtonWidget({super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.black,
        padding: EdgeInsets.symmetric(horizontal: 49, vertical: 10),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.white,
          fontFamily: "SFPro",
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
