import 'package:flutter/material.dart';
import 'package:task_manager/common/widgets/custom_app_bar.dart';

class TermsAndConditionPage extends StatelessWidget {
  const TermsAndConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Terms & Conditions"),
    );
  }
}
