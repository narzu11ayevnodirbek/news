import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news/core/utils/app_colors.dart';
import 'package:news/core/utils/app_icons.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        centerTitle: false,
        surfaceTintColor: AppColors.white,
        title: Text(
          "Terms & Conditions",
          style: TextStyle(
            color: AppColors.black,
            fontFamily: "SFPro",
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "By downloading or using this application , you agree to be bound by these Terms and Conditions. Please read them carefully before using the app. If you do not agree with any part of these terms, you should not use the app. This app is developed to provide users with access to news content, including but not limited to articles, headlines, summaries, images, and videos. The information presented in the app is for general informational purposes only and should not be considered as professional or legal advice. All content provided in the app, including text, images, logos, and data, is either owned by us or licensed to us. Users are not permitted to copy, modify, distribute, or exploit any content from the app without prior written permission. Any unauthorized use may violate copyright, trademark, and other applicable laws. This app may contain links to external websites or services that are not operated by us. We have no control over the content or practices of any third-party services and assume no responsibility for them. You acknowledge and agree that we shall not be held liable for any loss or damage caused by the use of such third-party content. Users may be required to create an account in order to access certain features of the app. You are responsible for maintaining the confidentiality of your login credentials and for all activities under your account. You agree to provide accurate and up-to-date information when creating or updating your account. We value your privacy. Any data collected through the app will be handled in accordance with our Privacy Policy, which explains what data we collect, how we use it, and your rights regarding your personal information. We reserve the right to modify, suspend, or discontinue the app or any part of it at any time without prior notice. We also reserve the right to update these Terms and Conditions at our sole discretion. Continued use of the app after any changes constitutes your acceptance of the new terms. The app and all its content are provided “as is” and “as available” without any warranties of any kind, either express or implied. We do not guarantee the accuracy, reliability, or completeness of any content or service provided through the app.These Terms and Conditions shall be governed and construed in accordance with the laws of [Your Country], without regard to its conflict of law provisions. If you have any questions or concerns about these Terms and Conditions, please contact us at [your email address].",
                      style: TextStyle(
                        color: AppColors.black,
                        fontFamily: "SFPro",
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
