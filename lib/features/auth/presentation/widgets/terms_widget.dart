import 'package:flutter/material.dart';
import 'package:news/core/utils/app_colors.dart';

class TermsWidget extends StatelessWidget {
  const TermsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "By signing up to News24 you are accepting our\n",
        style: TextStyle(
          color: AppColors.black,
          fontFamily: "SFPro",
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(
            text: "Terms & Conditions",
            style: TextStyle(
              color: AppColors.black,
              fontFamily: "SFPro",
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
