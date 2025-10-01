import 'package:flutter/material.dart';
import 'package:task_manager/app_theme.dart';
import 'package:task_manager/common/widgets/custom_app_bar.dart';
import 'package:task_manager/utils/dimensions.dart';

class TermsAndConditionPage extends StatelessWidget {
  const TermsAndConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Terms & Conditions"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimensions.paddingSizeTwenty),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Last updated: January 1, 2025",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSection(
              context,
              "1. Acceptance of Terms",
              "By downloading, installing, or using the Task Manager application, you agree to be bound by these Terms and Conditions. If you do not agree to these terms, please do not use the application.",
            ),
            _buildSection(
              context,
              "2. Use License",
              "We grant you a limited, non-exclusive, non-transferable license to use the Task Manager application for personal, non-commercial purposes. You may not:\n\n• Modify, reverse engineer, or decompile the application\n• Use the application for any illegal or unauthorized purpose\n• Remove any copyright or proprietary notices",
            ),
            _buildSection(
              context,
              "3. User Data",
              "All task data created within the application is stored locally on your device using SQLite database. We do not collect, store, or have access to your personal task information. You are responsible for maintaining backups of your data.",
            ),
            _buildSection(
              context,
              "4. Privacy",
              "Your privacy is important to us. The Task Manager application:\n\n• Does not collect personal information\n• Stores all data locally on your device\n• Does not share data with third parties\n• Does not require internet connection for core functionality",
            ),
            _buildSection(
              context,
              "5. Limitations of Liability",
              "The Task Manager application is provided \"as is\" without warranties of any kind. We are not liable for:\n\n• Any loss of data\n• Interruption of service\n• Any damages arising from the use of the application\n• Any indirect, incidental, or consequential damages",
            ),
            _buildSection(
              context,
              "6. User Responsibilities",
              "You are responsible for:\n\n• Maintaining the confidentiality of your device\n• All activities that occur on your device\n• Backing up your task data\n• Using the application in compliance with all applicable laws",
            ),
            _buildSection(
              context,
              "7. Modifications to Terms",
              "We reserve the right to modify these Terms and Conditions at any time. Changes will be effective immediately upon posting. Your continued use of the application after any modifications constitutes acceptance of the updated terms.",
            ),
            _buildSection(
              context,
              "8. Termination",
              "We may terminate or suspend your access to the application immediately, without prior notice, for any reason whatsoever, including without limitation if you breach the Terms and Conditions.",
            ),
            _buildSection(
              context,
              "9. Governing Law",
              "These Terms and Conditions are governed by and construed in accordance with the laws of the jurisdiction in which you reside, without regard to its conflict of law provisions.",
            ),
            _buildSection(
              context,
              "10. Contact Information",
              "If you have any questions about these Terms and Conditions, please contact us at:\n\nEmail: legal@taskmanager.com\nWebsite: www.taskmanager.com/support",
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.chipBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.success,
                    size: 40,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Thank you for using Task Manager!",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "By using our app, you agree to these terms",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textMuted,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
