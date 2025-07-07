import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news/core/utils/app_colors.dart';

class SettingsItemWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String leading;
  final String title;
  final Widget? trailing;
  const SettingsItemWidget({
    super.key,
    this.onTap,
    required this.leading,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: SvgPicture.asset(
        leading,
        width: 16,
        height: 16,
        fit: BoxFit.scaleDown,
        color: AppColors.black,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.black,
          fontFamily: "SFPro",
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: trailing,
    );
  }
}
