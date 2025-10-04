import 'package:flutter/material.dart';
import 'package:habiba_task_manager/app_theme.dart';
import 'package:habiba_task_manager/common/widgets/custom_app_bar.dart';
import 'package:habiba_task_manager/utils/dimensions.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Privacy Policy"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimensions.paddingSizeTwenty),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.security,
                    color: AppColors.success,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Privacy Matters",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.success,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Effective Date: January 1, 2025",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSection(
              context,
              "Introduction",
              "Task Manager is committed to protecting your privacy. This Privacy Policy explains how we handle information when you use our Task Manager mobile application.",
              Icons.info_outline,
            ),
            _buildSection(
              context,
              "Information We DON'T Collect",
              "Our Task Manager app is designed with privacy in mind:\n\n• We do NOT collect any personal information\n• We do NOT track your location\n• We do NOT access your contacts\n• We do NOT require account registration\n• We do NOT store data on remote servers\n• We do NOT share data with third parties\n• We do NOT use analytics or tracking tools",
              Icons.block,
            ),
            _buildSection(
              context,
              "Local Data Storage",
              "All your task data is stored locally on your device using SQLite database:\n\n• Tasks, descriptions, and categories are saved on your device only\n• Data remains on your device unless you explicitly delete it\n• Uninstalling the app will remove all stored data\n• We have no access to your locally stored data\n• You are responsible for backing up your own data",
              Icons.phone_android,
            ),
            _buildSection(
              context,
              "Permissions",
              "Our app requires minimal permissions:\n\n• Storage: To save your task data locally\n• No internet permission required\n• No camera access\n• No microphone access\n• No contact list access",
              Icons.security,
            ),
            _buildSection(
              context,
              "Data Security",
              "We implement security measures to protect your local data:\n\n• Data is stored in a secure SQLite database\n• No data transmission over the internet\n• No cloud synchronization\n• Your data stays on your device\n• Device-level security (PIN, password, biometric) protects your data",
              Icons.lock,
            ),
            _buildSection(
              context,
              "Children's Privacy",
              "Our Task Manager app does not:\n\n• Knowingly collect information from children under 13\n• Market to children\n• Require age verification (as we don't collect any data)\n\nThe app can be safely used by all ages as no data leaves the device.",
              Icons.child_care,
            ),
            _buildSection(
              context,
              "Data Deletion",
              "You have complete control over your data:\n\n• Delete individual tasks anytime\n• Clear all data through app settings\n• Uninstall the app to remove all data\n• No data retention after deletion\n• No backup on our servers (as we don't have access)",
              Icons.delete_forever,
            ),
            _buildSection(
              context,
              "Contact Us",
              "If you have questions about this Privacy Policy:\n\nEmail: privacy@taskmanager.com\nWebsite: www.taskmanager.com/privacy",
              Icons.email,
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.1),
                    AppColors.success.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.verified_user,
                    color: AppColors.primary,
                    size: 40,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "100% Private & Secure",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Your data never leaves your device",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textMuted,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content, IconData icon) {
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
          Row(
            children: [
              Icon(
                icon,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
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
