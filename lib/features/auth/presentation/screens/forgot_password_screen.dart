import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news/core/utils/app_colors.dart';
import 'package:news/core/utils/app_icons.dart';
import 'package:news/core/widgets/button_widget.dart';
import 'package:news/features/auth/presentation/widgets/input_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            AppIcons.back,
            width: 6,
            height: 12,
            fit: BoxFit.scaleDown,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 46),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            SvgPicture.asset(AppIcons.logo, width: 90),
            const SizedBox(height: 20),
            Text(
              "News 24",
              style: TextStyle(
                color: AppColors.black,
                fontFamily: "SFPro",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 46),
            const Text(
              "Enter your email to be sent a reset password link.",
              style: TextStyle(
                color: AppColors.black,
                fontFamily: "SFPro",
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),
            InputWidget(controller: emailController, label: "Email"),
            const SizedBox(height: 25),
            ButtonWidget(onPressed: () {}, title: "Reset"),
            const SizedBox(height: 30),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
