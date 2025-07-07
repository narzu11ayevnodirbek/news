import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/core/services/notification_service.dart';
import 'package:news/core/utils/app_colors.dart';
import 'package:news/core/utils/app_icons.dart';
import 'package:news/features/settings/presentation/providers/settings_provider.dart';
import 'package:news/features/settings/presentation/widgets/settings_item_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Settings",
          style: TextStyle(
            color: AppColors.black,
            fontFamily: "SFPro",
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            ListTile(
              onTap: () {},
              leading: SvgPicture.asset(
                AppIcons.person,
                width: 16,
                height: 16,
                fit: BoxFit.scaleDown,
              ),
              title: Text(
                "Account",
                style: TextStyle(
                  color: AppColors.black,
                  fontFamily: "SFPro",
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: SvgPicture.asset(
                AppIcons.follow,
                width: 20,
                height: 20,
                fit: BoxFit.scaleDown,
              ),
            ),
            Divider(color: AppColors.lightGrey),
            SettingsItemWidget(
              leading: AppIcons.notification,
              title: "Push Notifications",
              trailing: Consumer(
                builder: (context, ref, _) {
                  final isEnabled = ref.watch(notificationEnabledProvider);
                  return Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: isEnabled,
                      onChanged: (value) {
                        ref.read(notificationEnabledProvider.notifier).state =
                            value;
                        if (value) {
                          NotificationService().init();
                        } else {
                          FirebaseMessaging.instance.deleteToken();
                          print("🔕 Notifications disabled");
                        }
                      },
                      activeColor: AppColors.white,
                      activeTrackColor: AppColors.black,
                      inactiveTrackColor: AppColors.white,
                      inactiveThumbColor: AppColors.grey,
                    ),
                  );
                },
              ),
            ),

            Divider(color: AppColors.lightGrey),
            SettingsItemWidget(
              onTap: () {},
              leading: AppIcons.about,
              title: "Terms & Conditions",
              trailing: SvgPicture.asset(
                AppIcons.follow,
                width: 20,
                height: 20,
                fit: BoxFit.scaleDown,
              ),
            ),
            Divider(color: AppColors.lightGrey),
            SettingsItemWidget(
              onTap: () {},
              leading: AppIcons.about,
              title: "About",
              trailing: SvgPicture.asset(
                AppIcons.follow,
                width: 20,
                height: 20,
                fit: BoxFit.scaleDown,
              ),
            ),
            Divider(color: AppColors.lightGrey),
            SettingsItemWidget(
              onTap: () {},
              leading: AppIcons.logout,
              title: "Log Out",
            ),
          ],
        ),
      ),
    );
  }
}
