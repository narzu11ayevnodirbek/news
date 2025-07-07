import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news/core/utils/app_colors.dart';
import 'package:news/core/utils/app_icons.dart';
import 'package:news/core/widgets/button_widget.dart';
import 'package:news/features/auth/presentation/providers/auth_provider.dart';
import 'package:news/features/auth/presentation/screens/signin_screen.dart';
import 'package:news/features/auth/presentation/screens/terms_screen.dart';
import 'package:news/features/auth/presentation/widgets/input_widget.dart';
import 'package:news/features/auth/presentation/widgets/terms_widget.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _signUp() async {
    final email = emailController.text.trim();
    final password = emailController.text.trim();

    await ref.read(authStateProvider.notifier).signUpWithEmail(email, password);

    final user = ref.read(authStateProvider).value;

    if (user != null) {
      debugPrint("User registered: ${user.email}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Padding(
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
              InputWidget(
                controller: emailController,
                label: "Email",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter email";
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}',
                  ).hasMatch(value)) {
                    return "Enter valid email";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 29),
              InputWidget(
                controller: passwordController,
                obscureText: true,
                label: "Password",
                suffix: SvgPicture.asset(
                  AppIcons.eye,
                  width: 16,
                  height: 16,
                  fit: BoxFit.scaleDown,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter password";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ButtonWidget(
                onPressed: authState.isLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          _signUp();
                        }
                      },
                title: authState.isLoading ? "Signing Up..." : "Sign Up",
              ),
              const SizedBox(height: 30),
              Row(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(child: Divider(color: AppColors.black)),
                  Text(
                    "or sign in",
                    style: TextStyle(
                      color: AppColors.black,
                      fontFamily: "SFPro",
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(child: Divider(color: AppColors.black)),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SigninScreen()),
                      );
                    },
                    child: SvgPicture.asset(
                      AppIcons.email,
                      width: 43,
                      height: 40,
                    ),
                  ),
                  SvgPicture.asset(AppIcons.google, width: 43, height: 40),
                  SvgPicture.asset(AppIcons.facebook, width: 43, height: 40),
                  SvgPicture.asset(AppIcons.twitter, width: 43, height: 40),
                  SvgPicture.asset(AppIcons.apple, width: 43, height: 40),
                ],
              ),
              const SizedBox(height: 62),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TermsScreen()),
                  );
                },
                child: const TermsWidget(),
              ),
              const SizedBox(height: 42),
            ],
          ),
        ),
      ),
    );
  }
}
