import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/app_theme.dart';
import 'package:task_manager/common/widgets/custom_app_bar.dart';
import 'package:task_manager/features/settings/views/about_us_page.dart';
import 'package:task_manager/features/settings/views/privacy_policy_page.dart';
import 'package:task_manager/features/settings/views/terms_and_condition_page.dart';
import 'package:task_manager/utils/dimensions.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Settings"),

      body: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeFifteen),
        child: Column(children: [

          SettingButton(
            title: "About Us",
            onTap: () {
              Get.to(() => const AboutUsPage());
            },
          ),
          SizedBox(height: Dimensions.paddingSizeFifteen),

          SettingButton(
            title: "Terms & Conditions",
            onTap: () {
              Get.to(() => const TermsAndConditionPage());
            },
          ),
          SizedBox(height: Dimensions.paddingSizeFifteen),

          SettingButton(
            title: "Privacy Policy",
            onTap: () {
              Get.to(() => const PrivacyPolicyPage());
            },
          ),

        ]),
      ),
    );
  }
}

class SettingButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const SettingButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.paddingSizeFifteen),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(Dimensions.radiusEight),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(children: [
          Icon(Icons.note_add, color: AppColors.primary),
          SizedBox(width: Dimensions.paddingSizeFifteen),
        
          Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: Dimensions.fontSizeSixteen)),
        ]),
      ),
    );
  }
}
